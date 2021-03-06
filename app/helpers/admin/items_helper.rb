module Admin::ItemsHelper
  def create_image(param_path)
    Image.create(title:       param_path[:img_title],
                 description: param_path[:img_description],
                 img:         param_path[:image].tempfile)
  end

  def add_new_or_default_image(param_path)
    default = Image.find_by(title: "Missing")
    param_path[:image] ? create_image(param_path) : default
  end

  def add_image(param_path)
    @image = add_new_or_default_image(param_path)
    @item.image = @image
    @item.save
  end

  def update_image(param_path)
    add_image(param_path) if param_path[:image]
  end

  def add_categories(category_ids)
    @categories = category_ids.map do |category_id|
      Category.find_by(id: category_id)
    end
    @categories.compact.each do |category|
      @item.categories << category
    end
  end

  def update_categories(category_ids)
    @item.categories.clear
    add_categories(category_ids)
  end
end
