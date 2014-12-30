require 'products_tab'
require 'customers_tab'

class MainWindow < Qt::MainWindow
	
	slots 'about()'
	
	def initialize( args )
		super(nil)

    create_products_model( args[:products] )
    create_customers_model( args[:customers] )

    @tab_widget = Qt::TabWidget.new
    @tab_widget.addTab( ProductsTab.new( @products_model, self ), tr( 'Productes' ) )
    @tab_widget.addTab( CustomersTab.new( @customers_model, self ), tr( 'Clients' ) )
    #@tab_widget.addTab(OrdersTab.new, tr( 'Comandes' ) )

    setCentralWidget( @tab_widget )

    create_actions
	  create_menus
  end

  private

  def create_products_model( products )
    @products_model = Qt::StandardItemModel.new( products.length, 7, self )
    @products_model.setHeaderData( 0, Qt::Horizontal, Qt::Variant.new( tr( 'Nom' ) ) )
    @products_model.setHeaderData( 1, Qt::Horizontal, Qt::Variant.new( tr( 'Preu Tenda' ) ) )
    @products_model.setHeaderData( 2, Qt::Horizontal, Qt::Variant.new( tr( 'Preu Coope' ) ) )
    @products_model.setHeaderData( 3, Qt::Horizontal, Qt::Variant.new( tr( 'Preu PVP' ) ) )
    @products_model.setHeaderData( 4, Qt::Horizontal, Qt::Variant.new( tr( 'Tipus' ) ) )
    @products_model.setHeaderData( 5, Qt::Horizontal, Qt::Variant.new( tr( 'IVA' ) ) )
    @products_model.setHeaderData( 6, Qt::Horizontal, Qt::Variant.new( tr( 'Pes/Un' ) ) )

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
      @products_model.setItem( row, 0, item_name )
      @products_model.setItem( row, 1, item_price_tienda )
      @products_model.setItem( row, 2, item_price_coope )
      @products_model.setItem( row, 3, item_price_pvp )
      @products_model.setItem( row, 4, item_price_type )
      @products_model.setItem( row, 5, item_price_iva )
      @products_model.setItem( row, 6, item_weight_per_unit )

      @products_model.setData( @products_model.index( row, 1 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      @products_model.setData( @products_model.index( row, 2 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      @products_model.setData( @products_model.index( row, 3 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      @products_model.setData( @products_model.index( row, 4 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      @products_model.setData( @products_model.index( row, 5 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      @products_model.setData( @products_model.index( row, 6 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
    end
  end

  def create_customers_model( customers )
    @customers_model = Qt::StandardItemModel.new( customers.length, 4, self )
    @customers_model.setHeaderData( 0, Qt::Horizontal, Qt::Variant.new( tr( 'Nom' ) ) )
    @customers_model.setHeaderData( 1, Qt::Horizontal, Qt::Variant.new( tr( 'Adressa' ) ) )
    @customers_model.setHeaderData( 2, Qt::Horizontal, Qt::Variant.new( tr( 'Tipus' ) ) )
    @customers_model.setHeaderData( 3, Qt::Horizontal, Qt::Variant.new( tr( 'NIF' ) ) )

    customers.each_with_index do | customer, row |
      item_name = Qt::StandardItem.new( customer.name )
      item_address = Qt::StandardItem.new( customer.address )
      item_type = Qt::StandardItem.new( customer.type )
      item_nif = Qt::StandardItem.new( customer.nif )

      # setItem ( int row, QStandardItem * item )
      @customers_model.setItem( row, 0, item_name )
      @customers_model.setItem( row, 1, item_address )
      @customers_model.setItem( row, 2, item_type )
      @customers_model.setItem( row, 3, item_nif )

      @customers_model.setData( @customers_model.index( row, 1 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      @customers_model.setData( @customers_model.index( row, 2 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
      @customers_model.setData( @customers_model.index( row, 3 ), qVariantFromValue( Qt::AlignRight ), Qt::TextAlignmentRole )
    end
  end
	
	def about
	  Qt::MessageBox.about(self, tr('Ecocity Porc'), tr( 'Autor: Raul Ferrandez Salvador' ) )
	end
	
	def create_actions
    @about_action = Qt::Action.new(tr("&About"), self)
    @about_action.statusTip = tr("Show the application's About box")
    connect( @about_action, SIGNAL('triggered()'), self, SLOT('about()') )
	end
	
	def create_menus
    @help_menu = menuBar().addMenu(tr("&Help"))
    @help_menu.addAction(@about_action)
	end

end
