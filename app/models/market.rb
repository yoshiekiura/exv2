# People exchange commodities in markets. Each market focuses on certain
# commodity pair `{A, B}`. By convention, we call people exchange A for B
# *sellers* who submit *ask* orders, and people exchange B for A *buyers*
# who submit *bid* orders.
#
# ID of market is always in the form "#{B}#{A}". For example, in 'btccny'
# market, the commodity pair is `{btc, cny}`. Sellers sell out _btc_ for
# _cny_, buyers buy in _btc_ with _cny_. _btc_ is the `base_unit`, while
# _cny_ is the `quote_unit`.

class Market < ActiveRecord::Base
  
  default_scope { order(position: :asc) }
  scope :visible, -> { where(visible: true) }
  
  def base_unit
    ask_unit
  end

  def quote_unit
    bid_unit
  end

  def bid
    { fee: bid_fee, currency: bid_unit, fixed: bid_precision }
  end

  def ask
    { fee: ask_fee, currency: ask_unit, fixed: ask_precision }
  end

  def name
    "#{ask_unit}/#{bid_unit}".upcase
  end

  def as_json(*)
    super.merge!(name: name)
  end

  alias to_s name
  
  def latest_price
    Trade.latest_price(self)
  end

  # type is :ask or :bid
  def fix_number_precision(type, d)
    d.round send("#{type}_precision"), BigDecimal::ROUND_DOWN
  end

  # shortcut of global access
  def bids;   global.bids   end
  def asks;   global.asks   end
  def trades; global.trades end
  def ticker; global.ticker end

  def scope?(account_or_currency)
    code = if account_or_currency.is_a? Account
             account_or_currency.currency
           elsif account_or_currency.is_a? Currency
             account_or_currency.code
           else
             account_or_currency
           end

    ask_unit == code || bid_unit == code
  end

  def unit_info
    {name: name, base_unit: ask_unit, quote_unit: bid_unit}
  end

  private

  def global
    Global[id]
  end

end
