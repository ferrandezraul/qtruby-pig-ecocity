class ProductsModel

  COLUMN_NAME            = 0
  COLUMN_PRICE_TIENDA    = 1
  COLUMN_PRICE_COOPE     = 2
  COLUMN_PRICE_PVP       = 3
  COLUMN_PRICE_TYPE      = 4
  COLUMN_IVA             = 5
  COLUMN_WEIGHT_PER_UNIT = 6
  NUMBER_OF_COLUMNS      = 7

  def self.get_model( products, parent )
    products_model = Qt::StandardItemModel.new( products.length, NUMBER_OF_COLUMNS, parent )
    products_model.setHeaderData( 0, Qt::Horizontal, Qt::Variant.new( 'Nom' ) )
    products_model.setHeaderData( 1, Qt::Horizontal, Qt::Variant.new( 'Preu Tenda' ) )
    products_model.setHeaderData( 2, Qt::Horizontal, Qt::Variant.new( 'Preu Coope' ) )
    products_model.setHeaderData( 3, Qt::Horizontal, Qt::Variant.new( 'Preu PVP' ) )
    products_model.setHeaderData( 4, Qt::Horizontal, Qt::Variant.new( 'Tipus' ) )
    products_model.setHeaderData( 5, Qt::Horizontal, Qt::Variant.new( 'IVA' ) )
    products_model.setHeaderData( 6, Qt::Horizontal, Qt::Variant.new( 'Pes/Un'  ) )

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
          item_name.setChild( option_row, COLUMN_NAME, item_option_name )
        end
      end

      # setItem ( int row, QStandardItem * item )
      products_model.setItem( row, COLUMN_NAME, item_name )
      products_model.setItem( row, COLUMN_PRICE_TIENDA, item_price_tienda )
      products_model.setItem( row, COLUMN_PRICE_COOPE, item_price_coope )
      products_model.setItem( row, COLUMN_PRICE_PVP, item_price_pvp )
      products_model.setItem( row, COLUMN_PRICE_TYPE, item_price_type )
      products_model.setItem( row, COLUMN_IVA, item_price_iva )
      products_model.setItem( row, COLUMN_WEIGHT_PER_UNIT, item_weight_per_unit )

      products_model.setData( products_model.index( row, 1 ), Qt::Variant.fromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 2 ), Qt::Variant.fromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 3 ), Qt::Variant.fromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 4 ), Qt::Variant.fromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 5 ), Qt::Variant.fromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      products_model.setData( products_model.index( row, 6 ), Qt::Variant.fromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
    end

    products_model
  end

end