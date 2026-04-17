#Create public key to SSH into EC2 instance 
resource "aws_key_pair" "fastapi-dev-public-key" {

  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJy8uEAPguYfKqSudZFABbMmaA91FMbjM9NH+1W4TdjsFDRtNNuHaABOSsdZbaKQ7b+I0yEeYr/+aU/CV1TcnpXCkkcnXwIwSncwb2r2hFdjUY8tg5aqAGnLhhhF4mDvQx+a4twDbBItZNORD1x47ihpAvYM4isbY62LUsuSL55KJMMryChRtGSVPt/13UCk7EVqqey8zdcdvKHdD8FHg4hMtFBLoIh6bX1x7s8EgDValDkYUIxpNTfUl7Jj/X+y531UyXYuFKaP3r9+2gNmcjI9w6j/YF5TOyUEYaIoZ1qK1MmOapxhJYiR03aSB5RmoPxRIFMm8O5RTby1DebEaT dylancorrgmit@LAPTOP-JAS8EFJV"

}