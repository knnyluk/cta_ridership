require 'spec_helper'

describe Stop do
  it { should have_db_column(:street_on) }
  it { should have_db_column(:street_cross) }
  it { should have_db_column(:boardings) }
  it { should have_db_column(:alightings) }
  it { should have_many(:routes) }
end
