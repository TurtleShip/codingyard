module SolutionsHelper

  def can_upload
    unless logged_in?
      store_location
      flash[:danger] = 'Please login to upload a solution.'
      redirect_to login_url
    end
  end

  # Uploads the given file to the given path.
  # Returns true if upload wa successful. False otherwise.
  def upload_solution(path, file)
    begin
      resp = s3_client.put_object(bucket: master_bucket, key: path, body: file)
      resp.successful?
    rescue Exception => e
      logger.warn "Had trouble uploading to #{path}"
      logger.warn e.message
      false
    end
  end

  def solution_content(path)
    begin
      resp = s3_client.get_object(bucket: master_bucket, key: path)
      return resp.body.read if resp.successful?
      false
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

    def master_bucket
      @master_bucket_name ||= ENV['MASTER_BUCKET']
    end

end