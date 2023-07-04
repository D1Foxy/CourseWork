using Microsoft.EntityFrameworkCore;
using CourseWork.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Diagnostics;

namespace CourseWork
{
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
        }

        private void loginButton_Click(object sender, RoutedEventArgs e)
        {
            using (CourseWorkContext db = new CourseWorkContext())
            {
                User user = db.Users.Where(u => u.Login == loginBox.Text && u.Password == passwordBox.Password).Include(u => u.RoleNavigation).FirstOrDefault() as User;

                // admin
                if (user != null)
                {
                    new MainWindow(user).Show();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Неуспешная авторизация");
                }
            }
        }

        private void exitButton_Click(object sender, RoutedEventArgs e)
        {
            var exit = MessageBox.Show(
            "Вы действительно хотите закрыть приложение?",
              "Выход из приложения", MessageBoxButton.YesNo);

            if (exit == MessageBoxResult.Yes)
                Application.Current.Shutdown();
        }

        private void referenceButton_Click(object sender, RoutedEventArgs e)
        {
            Process.Start(@"Reference.chm");
        }
    }
}
