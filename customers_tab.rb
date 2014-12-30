class CustomersTab < Qt::Widget

  def initialize( customers, parent = nil )
    super(parent)

    products_model = Qt::StandardItemModel.new( customers.length, 4, self )
    products_model.setHeaderData( 0, Qt::Horizontal, Qt::Variant.new( tr( 'Nom' ) ) )
    products_model.setHeaderData( 1, Qt::Horizontal, Qt::Variant.new( tr( 'Adressa' ) ) )
    products_model.setHeaderData( 2, Qt::Horizontal, Qt::Variant.new( tr( 'Tipus' ) ) )
    products_model.setHeaderData( 3, Qt::Horizontal, Qt::Variant.new( tr( 'NIF' ) ) )


    customers.each_with_index do | customer, row |
      item_name = Qt::StandardItem.new( customer.name )
      item_address = Qt::StandardItem.new( customer.address )
      item_type = Qt::StandardItem.new( customer.type )
      item_nif = Qt::StandardItem.new( customer.nif )

      # setItem ( int row, QStandardItem * item )
      products_model.setItem( row, 0, item_name )
      products_model.setItem( row, 1, item_address )
      products_model.setItem( row, 2, item_type )
      products_model.setItem( row, 3, item_nif )

      products_model.setData( products_model.index( row, 1 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 2 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 3 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
    end

    view = Qt::TreeView.new
    view.model = products_model
    view.windowTitle = 'Customers Tree Model'
    view.show

    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( view )

      # Add spacer
      #m.addStretch( 1 )
    end

  end

end