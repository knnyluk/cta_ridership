require 'spec_helper'

describe Route do
  it { should have_db_column(:number) }  
  it { have_and_belong_to_many(:stops) }
end