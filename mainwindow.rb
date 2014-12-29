require './products_tab'

class MainWindow < Qt::MainWindow
	
	slots 'about()'
	
	def initialize( args )
		super(nil)

    @tab_widget = Qt::TabWidget.new
    @tab_widget.addTab( ProductsTab.new( args[:products], self ), tr( 'Productes' ) )
    #@tab_widget.addTab(CustomersTab.new, tr( 'Clients' ) )
    #@tab_widget.addTab(OrdersTab.new, tr( 'Comandes' ) )

    setCentralWidget( @tab_widget )

    create_actions
	  create_menus
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
