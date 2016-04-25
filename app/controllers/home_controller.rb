class HomeController < ApplicationController

  def index
    # Para la página principal, donde saldrán todas las submissions sin ningun criterio
    @submissions = Submission.all
  end

  def news
    # Para la ventana news, las submissions más recientes
    @news = Submission.all.order(created_at: :desc)
  end

  def comments
    # Para la ventana comentarios, ordenados por fecha creacion
    @comments = Comment.all.order(created_at: :desc)
  end



end
