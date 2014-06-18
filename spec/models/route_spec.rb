require 'spec_helper'

describe Route do
  it { should have_db_column(:number) }  
  it { should have_many(:stops) }
end