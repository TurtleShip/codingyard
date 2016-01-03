class StaticPagesController < ApplicationController

  def home
    @codeforces_total = CodeforcesRoundSolution.count
    @topcoder_srm_total = TopCoderSrmSolution.count
    @uva_total = UvaSolution.count
    @activated_user_total = User.where(activated: true).count

    # Top 3 users who uploaded the most solutions
    @top_uploaders = User.order(solutions_count: :desc).limit(3)

    # TOp 3 uva uploader
    # User.order(uva_solutions_count: :desc).limit(3)

    # Top 3 topcoder uploader
    # User.order(top_coder_srm_solutions_count: :desc).limit(3)

    # Top 3 Codeforces uploader
    # User.order(codeforces_round_solutions_count: :desc).limit(3)

    # Top 3 solutions with most likes


  end
end
