require 'date_dialog'
require 'customer_dialog'
require 'line_items_dialog'

class NewOrderDialog < Qt::Widget
  attr_reader :customer
  attr_reader :date
  attr_reader :line_items

  def initialize( products, customers, parent = nil )
    super( parent )

    get_date
    get_customer( customers ) if @date
    get_line_items(@customer, products) if customer
  end

  # Returns a Qt::Date object
  def get_date
    date_dialog = DateDialog.new(self)
    if date_dialog.exec == 1  # if user accepted the dialog
      @date = date_dialog.get_date
    end
  end

  def get_customer( customers )
    customer_dialog = CustomerDialog.new( customers, self)
    if customer_dialog.exec == 1  # if user accepted the dialog
      @customer = customer_dialog.get_customer
    end
  end

  def get_line_items( customer, products )
    line_items_dialog = LineItemsDialog.new( products, customer, self )
    if line_items_dialog.exec == 1
      @line_items = line_items_dialog.get_line_items
    else
      @line_items = Array.new
    end
  end

end