class DashboardController < ApplicationController
  before_action :require_login

  def index

    # add the valuation data
    @chart_data = [ { name: "Valuation", data: current_user.valuations.group_by_year(:date).sum(:value) } ]

    # build out the planned timeline for each goal
    current_user.goals.each do |g|

      # todo figure out a way to iterate years using startdate..enddate
      goal_data = {}
      d = g.start_date
      gv = g.start_value

      loop do
        break if d > g.end_date
        # todo derive this based on rate of return
        gv = gv + g.rate_of_savings
        goal_data[d] = gv
        d = d.next_year
      end

      #gd = { Date.new(2000,1,1) => 1000, Date.new(2001,1,1) => 2000 }
      @chart_data.push ( { name: g.name, data: goal_data } )

    end

  end

end
