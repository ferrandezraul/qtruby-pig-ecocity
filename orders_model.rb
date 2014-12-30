class OrdersModel

  COLUMN_DATE                 = 0
  COLUMN_ORDER_ITEMS          = 0  # Same as DATE since it will be a child column
  COLUMN_CUSTOMER             = 1
  COLUMN_TOTAL_WITHOUT_TAXES  = 2
  COLUMN_TAXES                = 3
  COLUMN_TOTAL                = 4
  NUMBER_OF_COLUMNS           = 5

  def self.get_model( orders, parent )
    customers_model = Qt::StandardItemModel.new( orders.length, NUMBER_OF_COLUMNS, parent )
    customers_model.setHeaderData( COLUMN_DATE, Qt::Horizontal, Qt::Variant.new( 'Data' ) )
    customers_model.setHeaderData( COLUMN_CUSTOMER, Qt::Horizontal, Qt::Variant.new( 'Client' ) )
    customers_model.setHeaderData( COLUMN_TOTAL_WITHOUT_TAXES, Qt::Horizontal, Qt::Variant.new( 'Total sense IVA' ) )
    customers_model.setHeaderData( COLUMN_TAXES, Qt::Horizontal, Qt::Variant.new( 'IVA' ) )
    customers_model.setHeaderData( COLUMN_TOTAL, Qt::Horizontal, Qt::Variant.new( 'Total' ) )

    orders.each_with_index do | order, row |
      item_customer_name = Qt::StandardItem.new( order.customer.name )
      item_date = Qt::StandardItem.new( order.date )
      item_total_without_taxes = Qt::StandardItem.new( order.total_without_taxes )
      item_taxes = Qt::StandardItem.new( order.taxes )
      item_total = Qt::StandardItem.new( order.total )

      # setItem ( int row, QStandardItem item )
      customers_model.setItem( row, COLUMN_DATE, item_date )
      customers_model.setItem( row, COLUMN_CUSTOMER, item_customer_name )
      customers_model.setItem( row, COLUMN_TOTAL_WITHOUT_TAXES, item_total_without_taxes )
      customers_model.setItem( row, COLUMN_TAXES, item_taxes )
      customers_model.setItem( row, COLUMN_TOTAL, item_total )

      # Align text in columns to the right
      customers_model.setData( customers_model.index( row, COLUMN_CUSTOMER ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
      customers_model.setData( customers_model.index( row, COLUMN_TOTAL_WITHOUT_TAXES ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
      customers_model.setData( customers_model.index( row, COLUMN_TAXES ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
      customers_model.setData( customers_model.index( row, COLUMN_TOTAL ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
    end

    customers_model
  end

end