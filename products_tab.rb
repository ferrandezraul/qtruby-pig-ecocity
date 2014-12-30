require 'products_tree_model'
require 'logger'

class ProductsTab < Qt::Widget

  def initialize( products, parent = nil )
    super(parent)
    @log = Logger.new('development.log', 'monthly')

    #products_model = ProductsTreeModel.new( products )

    products_model = Qt::StandardItemModel.new( products.length, 6, self )
    products_model.setHeaderData( 0, Qt::Horizontal, Qt::Variant.new( tr( 'Name' ) ) )
    products_model.setHeaderData( 1, Qt::Horizontal, Qt::Variant.new( tr( 'Preu Tenda' ) ) )
    products_model.setHeaderData( 2, Qt::Horizontal, Qt::Variant.new( tr( 'Preu Coope' ) ) )
    products_model.setHeaderData( 3, Qt::Horizontal, Qt::Variant.new( tr( 'Preu PVP' ) ) )
    products_model.setHeaderData( 4, Qt::Horizontal, Qt::Variant.new( tr( 'Tipus' ) ) )
    products_model.setHeaderData( 5, Qt::Horizontal, Qt::Variant.new( tr( 'IVA' ) ) )
    products_model.setHeaderData( 6, Qt::Horizontal, Qt::Variant.new( tr( 'Pes/Un' ) ) )


    products.each_with_index do | product, row |
      # insertRows ( int row, int count, const QModelIndex & parent = QModelIndex() )
      products_model.insertRows( row, 1 )

      # setData ( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole )
      products_model.setData( products_model.index( row, 0 ), Qt::Variant.new( product.name ) )

      products_model.setData( products_model.index( row, 1 ), Qt::Variant.new( "#{product.price_tienda} EUR" ) )
      products_model.setData( products_model.index( row, 1 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )

      products_model.setData( products_model.index( row, 2 ), Qt::Variant.new( "#{product.price_coope} EUR" ) )
      products_model.setData( products_model.index( row, 2 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )

      products_model.setData( products_model.index( row, 3 ), Qt::Variant.new( "#{product.price_pvp} EUR") )
      products_model.setData( products_model.index( row, 3 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )

      products_model.setData( products_model.index( row, 4 ), Qt::Variant.new( product.price_type ) )
      products_model.setData( products_model.index( row, 4 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )

      products_model.setData( products_model.index( row, 5 ), Qt::Variant.new( "#{product.iva} %" ) )
      products_model.setData( products_model.index( row, 5 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )

      products_model.setData( products_model.index( row, 6 ), Qt::Variant.new( "#{product.weight_per_unit} Kg/Un" ) )
      products_model.setData( products_model.index( row, 6 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )

      if product.has_options?
        parent_index = products_model.index( row, 0 )
        @log.debug( "Parent index contains #{parent_index.data.toString}")
        @log.debug( "Parent index is valid #{parent_index.isValid}")
        product.options.each_with_index do | option, option_row |
          inserted = products_model.insertRows( option_row, 1, parent_index )
          @log.debug( "Child row inserted #{inserted} for option name #{option.name}" )
          child_model_index = products_model.index( row, 0 ).child( option_row, 0 )

          @log.debug( "New model index #{child_model_index.isValid}" )
          setted = products_model.setData( child_model_index, Qt::Variant.new( option.name ) )
          @log.debug( "Data set #{setted}")

          index_inserted = products_model.index( row, 0 ).child( option_row, 0 )
          @log.debug( "Data inserted #{index_inserted.data.toString}" )
        end
      end

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