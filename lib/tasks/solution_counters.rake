namespace :solution_counters do


  desc 'resets solutions counters'
  task :reset => :environment do
    puts '====== Resetting solutions counters ======'

    User.reset_column_information

    User.all.each do |user|
      puts "Updating user #{user.username}"
      User.reset_counters(user.id, :codeforces_round_solutions)
      User.reset_counters(user.id, :top_coder_srm_solutions)
      User.reset_counters(user.id, :uva_solutions)

      user.update_attribute(:solutions_count,
                            user.codeforces_round_solutions_count +
                                user.top_coder_srm_solutions_count + user.uva_solutions_count)

      user.reload
    end
    puts '====== Solution counters all set ======'
  end


end
