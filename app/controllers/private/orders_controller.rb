module Private
  class OrdersController < BaseController
    include Concerns::OrderCreation
    def destroy
      ActiveRecord::Base.transaction do
        order = current_user.orders.find(params[:id])
        ordering = Ordering.new(order)

        if ordering.cancel
          render status: 200, nothing: true
        else
          render status: 500, nothing: true
        end
      end
    end

    def clear
      @orders = current_user.orders.with_currency(current_market).with_state(:wait)
      Ordering.new(@orders).cancel
      render status: 200, nothing: true
    end

    def create
      Rails.logger.debug "Creating this thing #{params}"
      if params[:commit] == "Sell"
        @order = OrderAsk.new(order_params(:order_ask))
        order_submit
      elsif params[:commit] == "Buy"
        @order = OrderBid.new(order_params(:order_bid))
        order_submit
      end
    end

  end
end