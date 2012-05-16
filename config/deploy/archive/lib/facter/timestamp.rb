Facter.add(:timestamp) do
  setcode do
    Time.now.strftime("%Y%m%d%H%M%S")
  end
end
