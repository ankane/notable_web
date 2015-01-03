module NotableWeb
  class HomeController < ActionController::Base
    layout "notable_web/application"

    http_basic_authenticate_with name: ENV["NOTABLE_USERNAME"], password: ENV["NOTABLE_PASSWORD"] if ENV["NOTABLE_PASSWORD"]

    def index
      where = Hash[ params.slice(:status, :note_type, :note, :user_id, :user_type).permit!.map{|k,v| ["notable_requests.#{k}", v] } ]

      page_method_name = Kaminari.config.page_method_name

      # https://github.com/rails/rails/issues/9055
      @requests = Notable::Request.order("notable_requests.id DESC").where(where).preload(:user).public_send(page_method_name, params[:page]).per(100)

      if params[:action_name]
        @requests = @requests.where(action: params[:action_name])
      end

      if params[:status]
        @requests = @requests.where("note_type != 'Slow Request'")
      end

      @requests =
        case params[:scope]
        when "slow_requests"
          @requests.where("action IS NOT NULL AND (status = 503 OR note_type = 'Slow Request')")
        when "referrer"
          @requests.where("referrer IS NOT NULL")
        when "external_referrer"
          domain = PublicSuffix.parse(request.host).domain rescue request.host
          @requests.where("referrer IS NOT NULL").where("referrer NOT LIKE ?", "%#{domain}%")
        else
          @requests
        end
    end

    def users
      requests = Notable::Request.where("created_at > ?", 1.day.ago)
      # yuck make this better
      user_ids = []
      counts = Hash.new(0)
      requests.select("user_id, user_type").order("created_at desc").where("user_id IS NOT NULL").each do |request|
        keys = [request.user_id, request.user_type]
        counts[keys] += 1
        user_ids << keys if counts[keys] == 3
        break if user_ids.size >= 20
      end
      groups = user_ids.group_by{|v| v[1] }
      where = [groups.map{|_, v| "(user_type = ? AND user_id IN (?))" }.join(" OR ")] + groups.flat_map{|v| [v[0], v[1].map{|v1| v1[0] }] }
      @users = requests.includes(:user).where(where).order("created_at DESC").group_by(&:user)
    end

    def slow_actions
      @top_actions = slow_requests.where("created_at > ?", 3.days.ago).select("action, SUM(request_time) AS total_time, AVG(request_time) AS average_time, COUNT(*) AS requests, SUM(CASE WHEN status = 503 THEN 1 ELSE 0 END) AS timeouts").group("action").order("total_time DESC").limit(50)
      @total_time_by_day = [{name: "Total Time (min)", data: slow_requests.group_by_day(:created_at, last: 14).sum("request_time").map{|k, v| [k, (v / 60.0).round] }}]
    end

    def slow_action
      @action = params[:action_name]
      @total_time_by_day = [{name: "Total Time (min)", data: slow_requests.where(action: @action).group_by_day(:created_at, last: 14).sum("request_time").map{|k, v| [k, (v / 60.0).round] }}]
    end

    protected

    def slow_requests
      Notable::Request.where("action IS NOT NULL AND (status = 503 OR note_type = 'Slow Request')")
    end

  end
end
