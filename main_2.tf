provider "null" {}

resource "null_resource" "install_mysql" {
  connection {
    type        = "ssh"
    host        = "192.168.***.***"
    user        = "your_username"
    password    = "your_password"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y mysql-server",
      "sudo systemctl start mysql",
      "sudo systemctl enable mysql"
    ]
  }
}

resource "null_resource" "setup_database" {
  depends_on = [null_resource.install_mysql]

  connection {
    type        = "ssh"
    host        = "192.168.***.***"
    user        = "your_username"
    password    = "your_password"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mysql -e 'CREATE DATABASE mydatabase;'",
      "sudo mysql -e 'USE mydatabase; CREATE TABLE mytable (id INT PRIMARY KEY, name VARCHAR(50));'"
    ]
  }
}

output "db_setup_complete" {
  value = "MySQL database and table setup complete on remote machine"
}
