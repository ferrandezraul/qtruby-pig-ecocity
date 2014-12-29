require './products_tab'

class MainWindow < Qt::MainWindow
	
	slots 'about()'
	
	def initialize( parent = nil )
		super

    @tab_widget = Qt::TabWidget.new
    @tab_widget.addTab(ProductsTab.new, tr( 'Productes' ) )
    #@tab_widget.addTab(CustomersTab.new, tr( 'Clients' ) )
    #@tab_widget.addTab(OrdersTab.new, tr( 'Comandes' ) )

    setCentralWidget( @tab_widget )

    createActions()
	  createMenus()
	end
	
	def about
	   Qt::MessageBox.about(self, tr('Ecocity Porc'), tr( 'Autor: Raul Ferrandez Salvador' ) )
	end
	
	def createActions
	    @about_action = Qt::Action.new(tr("&About"), self)
	    @about_action.statusTip = tr("Show the application's About box")
	    connect(@about_action, SIGNAL('triggered()'), self, SLOT('about()'))
	end
	
	def createMenus
	    @helpMenu = menuBar().addMenu(tr("&Help"))
	    @helpMenu.addAction(@about_action)
	end

end
