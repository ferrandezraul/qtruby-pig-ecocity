class CustomersModel

  COLUMN_NAME            = 0
  COLUMN_ADDRESS         = 1
  COLUMN_TYPE            = 2
  COLUMN_NIF             = 3
  NUMBER_OF_COLUMNS      = 4

  def self.get_model( customers, parent )
    customers_model = Qt::StandardItemModel.new( customers.length, NUMBER_OF_COLUMNS, parent )
    customers_model.setHeaderData( 0, Qt::Horizontal, Qt::Variant.new( 'Nom' ) )
    customers_model.setHeaderData( 1, Qt::Horizontal, Qt::Variant.new( 'Adressa' ) )
    customers_model.setHeaderData( 2, Qt::Horizontal, Qt::Variant.new( 'Tipus' ) )
    customers_model.setHeaderData( 3, Qt::Horizontal, Qt::Variant.new( 'NIF' ) )

    customers.each_with_index do | customer, row |
      item_name = Qt::StandardItem.new( customer.name )
      item_address = Qt::StandardItem.new( customer.address )
      item_type = Qt::StandardItem.new( customer.type )
      item_nif = Qt::StandardItem.new( customer.nif )

      item_name.setData( Qt::Variant.from_value( customer ) )

      # setItem ( int row, QStandardItem item )
      customers_model.setItem( row, COLUMN_NAME, item_name )
      customers_model.setItem( row, COLUMN_ADDRESS, item_address )
      customers_model.setItem( row, COLUMN_TYPE, item_type )
      customers_model.setItem( row, COLUMN_NIF, item_nif )

      # Align text in columns to the right
      customers_model.setData( customers_model.index( row, 1 ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
      customers_model.setData( customers_model.index( row, 2 ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
      customers_model.setData( customers_model.index( row, 3 ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
    end

    customers_model
  end

end