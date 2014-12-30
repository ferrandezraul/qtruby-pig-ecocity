require 'products_tree_model'

class ProductsTab < Qt::Widget

  def initialize( products, parent = nil )
    super(parent)

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
      products_model.insertRows( row, 1, Qt::ModelIndex.new() )

      item_name = Qt::StandardItem.new(  product.name )
      item_name.setData( qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )

      # setItem ( int row, QStandardItem * item )
      products_model.setItem( row, 0, item_name )

      # setData ( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole )
      #products_model.setData( products_model.index( row, 0, Qt::ModelIndex.new), Qt::Variant.new( product.name ) )

      products_model.setData( products_model.index( row, 1, Qt::ModelIndex.new), Qt::Variant.new( "#{product.price_tienda} EUR" ) )
      #products_model.item( row, 1).setData( Qt::AlignRight, Qt::TextAlignmentRole )

      products_model.setData( products_model.index( row, 2, Qt::ModelIndex.new), Qt::Variant.new( product.price_coope ) )
      products_model.setData( products_model.index( row, 3, Qt::ModelIndex.new), Qt::Variant.new( product.price_pvp ) )
      products_model.setData( products_model.index( row, 4, Qt::ModelIndex.new), Qt::Variant.new( product.price_type ) )
      products_model.setData( products_model.index( row, 5, Qt::ModelIndex.new), Qt::Variant.new( product.iva ) )
      products_model.setData( products_model.index( row, 6, Qt::ModelIndex.new), Qt::Variant.new( product.weight_per_unit ) )
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