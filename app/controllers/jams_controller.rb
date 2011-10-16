class JamsController < ApplicationController

  def index
    redirect_to '/'
  end

  def page1

  end

  def new
    session[:my_jam_id] = nil
    session[:my_archive_id] = nil
    redirect_to '/record'
  end

  def edit
    @jam = Jam.find(params[:jam])
    render 'page2'
  end

  def save

    unless params[:jam][:jam_id].present? && @jam = Jam.find(params[:jam][:jam_id])
      @jam = Jam.new
    end

    if params[:jam][:previous_archive_id].present?
      previous_archive = @jam.archives.select { |archive| archive["archive_id"] == params[:jam][:previous_archive_id] }.first
      @jam.archives.delete(previous_archive)
      # todo: remove from online archive
    end

    unless params[:jam][:new_archive_id].present?
      flash[:alert] = "Error saving video"
      logger.warn "Cannot create archive w/o archive id"
      redirect_to '/record'
      return
    end

    attributes = {
      :archive_id => params[:jam][:new_archive_id],
      :created_at => Time.now,
      :updated_at => Time.now
    }
    attributes.merge!({:user_id => current_user.id}) if current_user


    @jam.archives.create(attributes)
    if @jam.save
      session[:my_jam_id] = @jam.id
      session[:my_archive_id] = attributes[:archive_id]
      respond_with @jam
    else
      logger.warn "Error saving Jam."
      flash[:notice] = "There was an error saving, please try again"
      redirect_to :back
    end


  end

  def show
    @jam = Jam.find(params[:id])

    @jam.archives.sort! { |a,b| a.created_at <=> b.created_at }

    logger.warn  @jam.archives.first

    unless @jam
      flash[:alert] = "jam not found"
      redirect_to '/'
      return
    end

  end

  def complete_registration
    my_lastest_archive = Archive.find_ by_archive_id(session[:my_archive_id])
    my_lastest_archive.user_id = current_user.id

    redirect_to my_lastest_archive.jam
  end

  def join
    @jam = Jam.find(params[:id])
    session[:my_jam_id] = @jam.id

    redirect_to '/record'
  end

end
