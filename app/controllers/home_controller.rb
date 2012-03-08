require Rails.root + 'lib/csv_generator'

class HomeController < ApplicationController

  def index
    @images = header_images
    @thumbs = header_thumbs
    @titles = header_titles
  end

  def calendar
    @start = Time.now
    @finish = Time.now + 1.year
    respond_to do |format|
      format.html
      format.csv
      #format.gcal
      #format.ical
    end
  end

  def operations
    @start = Time.now
    @finish = Time.now + 1.year
    @filename = "operations.kml"
  end

  def alt
    if params['page'].nil?
      render 'index'
    else
      render params['page']
    end
  end

  private

  def header_images
    Dir.glob('public/images/static_gallery/*.jpg').sort.map do |path|
      path.gsub('public/', '')
    end
  end

  def header_thumbs
    header_images.reduce({}) do |a, image_path|
      thumbnail_path = image_path.split('/').insert(-2, "thumbs").join('/')
      a[image_path] = thumbnail_path
      a
    end
  end

  def header_titles
    header_images.reduce({}) do |a, image_path|
      filename = image_path.split('/').last
      basename = filename.split('.').first
      title = basename.split('_').map {|x| x.capitalize}.join(' ')
      a[image_path] = title
      a
    end
  end

end
