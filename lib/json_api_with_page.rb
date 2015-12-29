class JsonApiWithPage < ActiveModel::Serializer::Adapter::JsonApi
  def serializable_hash_for_collection(options)
    hash = super(options)
    object = serializer.object
    hash[:page] = {
      number: object.current_page, size: object.size,
      pages: object.total_pages, nextPage: object.next_page,
      prevPage: object.prev_page, perPage: object.limit_value
    }
    hash
  end
end