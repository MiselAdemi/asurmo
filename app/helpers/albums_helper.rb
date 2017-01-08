module AlbumsHelper
  def album_thumbnail(album)
    if album.pictures.count > 0
      image_tag(album.pictures.first.picture.url)
    else
      image_tag("http://placekitten.com/260/180")
    end
  end
end
