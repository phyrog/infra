class TorrentsController < ApplicationController
  before_action :set_torrent, only: [:show, :edit, :update, :destroy]

  # GET /torrents
  # GET /torrents.json
  def index
    if params[:q]
      torrents = Torrent.find_by_query(params[:q])
      @torrents = Torrent.where('id in (?)', torrents.map(&:id))
    else
      @torrents = Torrent.all
    end
  end

  # GET /torrents/1
  # GET /torrents/1.json
  def show
  end

  # GET /torrents/1/edit
  def edit
  end

  # POST /torrents
  # POST /torrents.json
  def create
    @torrent = Torrent.new(torrent_params)

    if not torrent_params[:name] or not torrent_params[:description]
      @torrent.file = Dragonfly.app.fetch(@torrent.file_uid) if @torrent.file_uid
      @torrent.file_uid = @torrent.file.job.store if @torrent.file
      @torrent.name = @torrent.to_h["info"]["name"] if @torrent.file
      @torrent.description = @torrent.to_h["comment"] if @torrent.file
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render action: 'show', location: @torrent }
      end
    else
      respond_to do |format|
        if @torrent.save
          format.html { redirect_to @torrent, notice: 'Torrent was successfully created.' }
          format.json { render action: 'show', status: :created, location: @torrent }
        else
          format.html { render action: 'new' }
          format.json { render json: @torrent.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /torrents/1
  # PATCH/PUT /torrents/1.json
  def update
    respond_to do |format|
      if @torrent.update(torrent_params)

        if property_params
          property_params.each do |param, value|
            prop = @torrent.properties.find_by(name: param)
            if prop
              if val = @torrent.value_of_property(prop)
                val.update(value: value)
              else
                @torrent.property_values.create(value: value, property: prop)
              end
            end
          end
        end

        format.html { redirect_to @torrent, notice: 'Torrent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @torrent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /torrents/1
  # DELETE /torrents/1.json
  def destroy
    @torrent.destroy
    respond_to do |format|
      format.html { redirect_to torrents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_torrent
      @torrent = Torrent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def torrent_params
      params.require(:torrent).permit(:name, :description, :file, :file_uid, :tags_string)
    end

    def property_params
      params[:property]
    end
end
