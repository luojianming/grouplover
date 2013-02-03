class ChangeVistorsToVisitorsInExtraInfo < ActiveRecord::Migration
  change_table :extra_infos do |t|
    t.rename :vistors, :visitors
  end
end
