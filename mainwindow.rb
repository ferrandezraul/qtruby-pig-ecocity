
class MainWindow < Qt::MainWindow
	
	slots 'about()'
	
	def initialize( parent = nil )
		super

	    createActions()
	    createMenus()
	end
	
	def about()
	   Qt::MessageBox.about(self, tr('Ecocity Porc'), tr( 'Autor: Raul Ferrandez Salvador' ) )
	end
	
	def createActions
	    @aboutAct = Qt::Action.new(tr("&About"), self)
	    @aboutAct.statusTip = tr("Show the application's About box")
	    connect(@aboutAct, SIGNAL('triggered()'), self, SLOT('about()'))
	
	    @aboutQtAct = Qt::Action.new(tr("About &Qt"), self)
	    @aboutQtAct.statusTip = tr("Show the Qt library's About box")
	    connect(@aboutQtAct, SIGNAL('triggered()'), $qApp, SLOT('aboutQt()'))
	end
	
	def createMenus
	    @helpMenu = menuBar().addMenu(tr("&Help"))
	    @helpMenu.addAction(@aboutAct)
	    @helpMenu.addAction(@aboutQtAct)
	end

end
