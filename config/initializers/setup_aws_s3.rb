# Rails.logger.info 'Setting up AWS S3 to store uploaded solutions...'
#
# s3 = Aws::S3::Client.new
#
# begin
#   s3.create_bucket({bucket: ENV['MASTER_BUCKET']})
#   Rails.logger.info "Created the master bucket #{ENV['MASTER_BUCKET']}"
# rescue Aws::S3::Errors::BucketAlreadyOwnedByYou
#   Rails.logger.info "#{ENV['MASTER_BUCKET']} already exists. Skipping master bucket creation."
# end
#
#
#
#
# Rails.logger.info 'AWS S3 setup was successful!'