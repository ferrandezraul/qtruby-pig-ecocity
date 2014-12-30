class ProductsTab < Qt::Widget

  def initialize( products, parent = nil )
    super(parent)

    products_model = Qt::StandardItemModel.new( products.length, 7, self )
    products_model.setHeaderData( 0, Qt::Horizontal, Qt::Variant.new( tr( 'Nom' ) ) )
    products_model.setHeaderData( 1, Qt::Horizontal, Qt::Variant.new( tr( 'Preu Tenda' ) ) )
    products_model.setHeaderData( 2, Qt::Horizontal, Qt::Variant.new( tr( 'Preu Coope' ) ) )
    products_model.setHeaderData( 3, Qt::Horizontal, Qt::Variant.new( tr( 'Preu PVP' ) ) )
    products_model.setHeaderData( 4, Qt::Horizontal, Qt::Variant.new( tr( 'Tipus' ) ) )
    products_model.setHeaderData( 5, Qt::Horizontal, Qt::Variant.new( tr( 'IVA' ) ) )
    products_model.setHeaderData( 6, Qt::Horizontal, Qt::Variant.new( tr( 'Pes/Un' ) ) )


    products.each_with_index do | product, row |
      item_name = Qt::StandardItem.new( product.name )
      item_price_tienda = Qt::StandardItem.new( "#{product.price_tienda} EUR" )
      item_price_coope = Qt::StandardItem.new( "#{product.price_coope} EUR" )
      item_price_pvp = Qt::StandardItem.new( "#{product.price_pvp} EUR" )
      item_price_type = Qt::StandardItem.new( product.price_type )
      item_price_iva = Qt::StandardItem.new( "#{product.iva} %" )
      item_weight_per_unit = Qt::StandardItem.new( "#{product.weight_per_unit} Kg/Un" )

      if product.has_options?
        product.options.each_with_index do | option, option_row |
          item_option_name = Qt::StandardItem.new( option.name )
          item_name.setChild( option_row, 0, item_option_name )
        end
      end

      # setItem ( int row, QStandardItem * item )
      products_model.setItem( row, 0, item_name )
      products_model.setItem( row, 1, item_price_tienda )
      products_model.setItem( row, 2, item_price_coope )
      products_model.setItem( row, 3, item_price_pvp )
      products_model.setItem( row, 4, item_price_type )
      products_model.setItem( row, 5, item_price_iva )
      products_model.setItem( row, 6, item_weight_per_unit )

      products_model.setData( products_model.index( row, 1 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 2 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 3 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 4 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 5 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 6 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
    end

    view = Qt::TreeView.new
    view.model = products_model
    view.windowTitle = 'Products Tree Model'
    view.show

    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( view )

      # Add spacer
      #m.addStretch( 1 )
    end

  end

end