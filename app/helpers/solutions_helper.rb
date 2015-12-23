module SolutionsHelper

  def can_upload
    unless logged_in?
      store_location
      flash[:danger] = 'Please login to upload a solution.'
      redirect_to login_url
    end
  end

  def can_delete
    unless logged_in? && (@solution.user == current_user || current_user.admin?)
      store_location
      flash[:danger] = 'You don\'t have permission to delete the solution.'
      redirect_to (request.referer || root_url)
    end
  end

  def can_edit
    unless logged_in? && (@solution.user == current_user || current_user.admin?)
      store_location
      flash[:danger] = 'You don\'t have permission to edit the solution.'
      redirect_to (request.referer || root_url)
    end
  end


  # Uploads the given file to the given path.
  # Returns true if upload was successful. False otherwise.
  def upload_solution(path, file)
    begin
      obj = bucket.put_object(key: path, body: file)
      obj.exists?
    rescue Exception => e
      logger.warn "Had trouble uploading to #{path}"
      logger.warn e.message
      false
    end
  end

  def solution_content(path)
    begin
      obj = bucket.object(path)
      return obj.get.body.read
    rescue Exception => e
      logger.warn "Had trouble downloading from #{path}"
      logger.warn e.message
      false
    end
  end

  private

    # AWS S3 Ruby Client doc :
    # http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Client.html
    def s3_client
      @s3 ||= Aws::S3::Client.new
    end

    def s3_resource
      @s3_resource ||= Aws::S3::Resource.new(client: s3_client)
    end

    def bucket
      @bucket ||= s3_resource.bucket(master_bucket_name)
    end

    def master_bucket_name
      @master_bucket_name ||= ENV['MASTER_BUCKET']
    end

end