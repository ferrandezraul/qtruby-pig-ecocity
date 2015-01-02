require 'products_tab'
require 'customers_tab'
require 'orders_tab'

require 'customers_model'
require 'products_model'
require 'orders_model'

class MainWindow < Qt::MainWindow
	
	slots 'about()'
	
	def initialize( args )
		super(nil)

    self.windowTitle = 'Ecocity Porc'

    @products_model = ProductsModel.get_model( args[:products], self )
    @customers_model = CustomersModel.get_model( args[:customers], self )
    @orders_model = OrdersModel.get_model( args[:orders], self )

    @tab_widget = Qt::TabWidget.new
    @tab_widget.addTab( ProductsTab.new( @products_model, self ), tr( 'Productes' ) )
    @tab_widget.addTab( CustomersTab.new( @customers_model, self ), tr( 'Clients' ) )
    @tab_widget.addTab( OrdersTab.new( @products_model, @customers_model, @orders_model, self ), tr( 'Comandes' ) )

    setCentralWidget( @tab_widget )

    create_actions
	  create_menus
  end

  private
	
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
