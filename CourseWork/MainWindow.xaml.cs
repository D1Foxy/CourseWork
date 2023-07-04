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

namespace CourseWork
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow(User user)
        {
            InitializeComponent();

            using (CourseWorkContext db = new CourseWorkContext())
            {
                statusUser.Text = $"{user.RoleNavigation.Name}: {user.Surname} {user.Name} {user.Patronymic} \r\t";
                MessageBox.Show($"{user.RoleNavigation.Name}: {user.Surname} {user.Name} {user.Patronymic} \r\t");

                studentslistView.ItemsSource = db.Students.ToList();

                List<string> sortList = new List<string>() { "По возрастанию среднего балла", "По убыванию среднего балла" };
                sortUserComboBox.ItemsSource = sortList.ToList();

                List<string> filtertList = db.Students.Select(u => u.Name).Distinct().ToList();
                filtertList.Insert(0, "Все имена");
                filterUserComboBox.ItemsSource = filtertList.ToList();

                countStudents.Text = $"Количество: {db.Students.Count()}";
            }

        }

        private void exitButtonClick(object sender, RoutedEventArgs e)
        {
            new LoginWindow().Show();
            this.Close();
        }

        private void sortUserComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            using (CourseWorkContext db = new CourseWorkContext())
            {
                if (sortUserComboBox.SelectedValue == "По убыванию среднего балла")
                {
                    studentslistView.ItemsSource = db.Students.OrderByDescending(u => u.Gpa).ToList();
                }

                if (sortUserComboBox.SelectedValue == "По возрастанию среднего балла")
                {
                    studentslistView.ItemsSource = db.Students.OrderBy(u => u.Gpa).ToList();
                }
            }
            UpdateStudents();
        }

        private void filterUserComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            using (CourseWorkContext db = new CourseWorkContext())
            {
                if (db.Students.Select(u => u.Name).Distinct().ToList().Contains(filterUserComboBox.SelectedValue))
                {
                    studentslistView.ItemsSource = db.Students.Where(u => u.Name == filterUserComboBox.SelectedValue).ToList();
                }
                else
                {
                    studentslistView.ItemsSource = db.Students.ToList();
                }
            }
            UpdateStudents();
        }

        private void searchBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            using (CourseWorkContext db = new CourseWorkContext())
            {
                if (searchBox.Text.Length > 0)
                {
                    studentslistView.ItemsSource = db.Students.Where(u => u.Name.Contains(searchBox.Text) || u.Surname.Contains(searchBox.Text)).ToList();
                }
            }
            UpdateStudents();
        }

        private void сlearButton_Click(object sender, RoutedEventArgs e)
        {
            searchBox.Text = "";
            sortUserComboBox.SelectedIndex = -1;
            filterUserComboBox.SelectedIndex = -1;
        }

        private void UpdateStudents()
        {
            using (CourseWorkContext db = new CourseWorkContext())
            {

                var currentStudents = db.Students.ToList();
                studentslistView.ItemsSource = currentStudents;

                //Сортировка
                if (sortUserComboBox.SelectedIndex != -1)
                {
                    if (sortUserComboBox.SelectedValue == "По убыванию среднего балла")
                    {
                        currentStudents = currentStudents.OrderByDescending(u => u.Gpa).ToList();
                    }

                    if (sortUserComboBox.SelectedValue == "По возрастанию среднего балла")
                    {
                        currentStudents = currentStudents.OrderBy(u => u.Gpa).ToList();
                    }
                }


                // Фильтрация
                if (filterUserComboBox.SelectedIndex != -1)
                {
                    if (db.Students.Select(u => u.Name).Distinct().ToList().Contains(filterUserComboBox.SelectedValue))
                    {
                        currentStudents = currentStudents.Where(u => u.Name == filterUserComboBox.SelectedValue.ToString()).ToList();
                    }
                    else
                    {
                        currentStudents = currentStudents.ToList();
                    }
                }

                // Поиск

                if (searchBox.Text.Length > 0)
                {
                    currentStudents = currentStudents.Where(u => u.Name.Contains(searchBox.Text) || u.Surname.Contains(searchBox.Text)).ToList();
                }
                studentslistView.ItemsSource = currentStudents;

                countStudents.Text = $"Количество: {currentStudents.Count} из {db.Students.ToList().Count}";
            }
        }

        private void addStudentButtonClick(object sender, RoutedEventArgs e)
        {
            new AddStudentWindow(null).ShowDialog();
        }

        private void delStudentButton(object sender, RoutedEventArgs e)
        {
            using (CourseWorkContext db = new CourseWorkContext())
            {
                var student = (studentslistView.SelectedItem) as Student;

                if (student != null)
                {

                    if (MessageBox.Show($"Вы точно хотите удалить {student.Name}", "Внимание!",
                        MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                    {
                        db.Students.Remove(student);
                        db.SaveChanges();
                        MessageBox.Show($"Студент {student.Name} удален!");
                        studentslistView.ItemsSource = db.Students.ToList();
                        countStudents.Text = $"Количество: {db.Students.Count()}";
                    }

                }
            }
        }

        private void EditStudent_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Student p = (sender as ListView).SelectedItem as Student;
            new AddStudentWindow(p).ShowDialog();
        }
    }
}
