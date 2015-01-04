class CustomersModel

  COLUMN_NAME            = 0
  COLUMN_ADDRESS         = 1
  COLUMN_TYPE            = 2
  COLUMN_NIF             = 3
  NUMBER_OF_COLUMNS      = 4

  def self.get_model( customers, parent )
    customers_model = Qt::StandardItemModel.new( 0, NUMBER_OF_COLUMNS, parent )
    customers_model.setHeaderData( 0, Qt::Horizontal, Qt::Variant.new( 'Nom' ) )
    customers_model.setHeaderData( 1, Qt::Horizontal, Qt::Variant.new( 'Adressa' ) )
    customers_model.setHeaderData( 2, Qt::Horizontal, Qt::Variant.new( 'Tipus' ) )
    customers_model.setHeaderData( 3, Qt::Horizontal, Qt::Variant.new( 'NIF' ) )

    customers.each do | customer |
      add_customer_to_model( customer, customers_model )
    end

    customers_model
  end

  def self.add_customer_to_model( customer, model )
    item_name = Qt::StandardItem.new( customer.name )
    item_address = Qt::StandardItem.new( customer.address )
    item_type = Qt::StandardItem.new( customer.type )
    item_nif = Qt::StandardItem.new( customer.nif )

    item_name.setData( Qt::Variant.from_value( customer ) )

    row = model.rowCount

    # setItem ( int row, QStandardItem item )
    model.setItem( row, COLUMN_NAME, item_name )
    model.setItem( row, COLUMN_ADDRESS, item_address )
    model.setItem( row, COLUMN_TYPE, item_type )
    model.setItem( row, COLUMN_NIF, item_nif )

    # Align text in columns to the right
    model.setData( model.index( row, COLUMN_ADDRESS ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
    model.setData( model.index( row, COLUMN_TYPE ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
    model.setData( model.index( row, COLUMN_NIF ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
  end

end