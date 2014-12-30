class CustomersModel

  def self.get_model( customers, parent )
    customers_model = Qt::StandardItemModel.new( customers.length, 4, parent )
    customers_model.setHeaderData( 0, Qt::Horizontal, Qt::Variant.new( 'Nom' ) )
    customers_model.setHeaderData( 1, Qt::Horizontal, Qt::Variant.new( 'Adressa' ) )
    customers_model.setHeaderData( 2, Qt::Horizontal, Qt::Variant.new( 'Tipus' ) )
    customers_model.setHeaderData( 3, Qt::Horizontal, Qt::Variant.new( 'NIF' ) )

    customers.each_with_index do | customer, row |
      item_name = Qt::StandardItem.new( customer.name )
      item_address = Qt::StandardItem.new( customer.address )
      item_type = Qt::StandardItem.new( customer.type )
      item_nif = Qt::StandardItem.new( customer.nif )

      # setItem ( int row, QStandardItem * item )
      customers_model.setItem( row, 0, item_name )
      customers_model.setItem( row, 1, item_address )
      customers_model.setItem( row, 2, item_type )
      customers_model.setItem( row, 3, item_nif )

      customers_model.setData( customers_model.index( row, 1 ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
      customers_model.setData( customers_model.index( row, 2 ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
      customers_model.setData( customers_model.index( row, 3 ), Qt::Variant.fromValue(Qt::AlignRight), Qt::TextAlignmentRole )
    end

    customers_model
  end

end