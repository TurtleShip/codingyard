class StaticPagesController < ApplicationController

  def home
    @codeforces_total = CodeforcesRoundSolution.count
    @topcoder_srm_total = TopCoderSrmSolution.count
    @uva_total = UvaSolution.count
  end
end
