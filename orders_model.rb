require 'ap'

class OrdersModel

  COLUMN_DATE                 = 0
  COLUMN_ORDER_ITEMS          = 0  # Same as DATE since it will be a child column
  COLUMN_CUSTOMER             = 1
  COLUMN_TOTAL_WITHOUT_TAXES  = 2
  COLUMN_TAXES                = 3
  COLUMN_TOTAL                = 4
  NUMBER_OF_COLUMNS           = 5

  def self.get_model( orders, parent )
    orders_model = Qt::StandardItemModel.new( 0, NUMBER_OF_COLUMNS, parent )
    orders_model.setHeaderData( COLUMN_DATE, Qt::Horizontal, Qt::Variant.new( 'Data' ) )
    orders_model.setHeaderData( COLUMN_CUSTOMER, Qt::Horizontal, Qt::Variant.new( 'Client' ) )
    orders_model.setHeaderData( COLUMN_TOTAL_WITHOUT_TAXES, Qt::Horizontal, Qt::Variant.new( 'Total sense IVA' ) )
    orders_model.setHeaderData( COLUMN_TAXES, Qt::Horizontal, Qt::Variant.new( 'IVA' ) )
    orders_model.setHeaderData( COLUMN_TOTAL, Qt::Horizontal, Qt::Variant.new( 'Total' ) )

    orders.each do | order |
      add_order_to_model(order, orders_model)
    end

    orders_model
  end

  def self.add_order_to_model( order, model )
    item_customer_name = Qt::StandardItem.new( order.customer.name )
    #item_date = Qt::StandardItem.new( order.date )
    item_total_without_taxes = Qt::StandardItem.new( order.total_without_taxes.round(2).to_s )
    item_taxes = Qt::StandardItem.new( order.taxes.round(2).to_s )
    item_total = Qt::StandardItem.new( order.total.round(2).to_s )

    #item_customer_name = Qt::StandardItem.new( "foo" )
    item_date = Qt::StandardItem.new( "foo" )
    #item_total_without_taxes = Qt::StandardItem.new( "foo" )
    #item_taxes = Qt::StandardItem.new( "foo" )
    #item_total = Qt::StandardItem.new( "foo" )

    row = model.rowCount

    # setItem ( int row, QStandardItem item )
    model.setItem( row, COLUMN_DATE, item_date )
    model.setItem( row, COLUMN_CUSTOMER, item_customer_name )
    model.setItem( row, COLUMN_TOTAL_WITHOUT_TAXES, item_total_without_taxes )
    model.setItem( row, COLUMN_TAXES, item_taxes )
    model.setItem( row, COLUMN_TOTAL, item_total )

    # Align text in columns to the right
    model.setData( model.index( row, COLUMN_CUSTOMER ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
    model.setData( model.index( row, COLUMN_TOTAL_WITHOUT_TAXES ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
    model.setData( model.index( row, COLUMN_TAXES ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
    model.setData( model.index( row, COLUMN_TOTAL ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
  end

end