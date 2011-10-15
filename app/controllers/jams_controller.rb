class JamsController < ApplicationController

  def page1
    @title = 'Home'
  end

  def page2

  end

  def save
    @jam = Jam.create(params[:jam])

    respond_with @jam
  end

  def show
    @jam = Jam.find(params[:id])

    unless @jam
      flash[:alert] = "jam not found"
      redirect_to '/'
      return
    end

  end

end
