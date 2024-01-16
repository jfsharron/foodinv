// =====================================================================================
//
// Program:		BratPack
// File: 		MainPage.xaml.cs
// Software Engineer: 	Jonas Sharron
// Date: 		21-April-2018
//
// Purpose: 	This file represents the C# code in an application that allows the
// 		user to select a type of backpack and have a sample image of their
 // 		selection displayed based on a button click.
 //
 // ====================================================================================


 using System;
 using System.Collections.Generic;
 using System.IO;
 using System.Linq;
 using System.Runtime.InteropServices.WindowsRuntime;
 using Windows.Foundation;
 using Windows.Foundation.Collections;
 using Windows.UI.Xaml;
 using Windows.UI.Xaml.Controls;
 using Windows.UI.Xaml.Controls.Primitives;
 using Windows.UI.Xaml.Data;
 using Windows.UI.Xaml.Input;
 using Windows.UI.Xaml.Media;
 using Windows.UI.Xaml.Navigation;
 using Windows.UI.Xaml.Media.Imaging;

 // The Blank Page item template is documented at
https://go.microsoft.com/fwlink/?LinkId=402352&clcid=0x409

 namespace BratPack
 {
 /// <summary>
 /// An empty page that can be used on its own or navigated to within a Frame.
 /// </summary>
 public sealed partial class MainPage : Page
 {
 public MainPage()
 {
 this.InitializeComponent();
 }
 // ======================================================================
 // method to display sample school pack
 private void schoolButton_Click(object sender, RoutedEventArgs e)
 {
 sampleImage.Visibility = Visibility.Visible;
 sampleImage.Source = new BitmapImage(new Uri("ms-appx:///Assets/school.jpg"));
 sampleTextBlock.Visibility = Visibility.Visible;
 sampleTextBlock.Text = "School";
 }
 // end school method
 // ======================================================================

 // ======================================================================
 // method to display sample sling pack
 private void slingButton_Click(object sender, RoutedEventArgs e)
 {
 sampleImage.Visibility = Visibility.Visible;
 sampleImage.Source = new BitmapImage(new Uri("ms-appx:///Assets/sling.jpg"));
 sampleTextBlock.Visibility = Visibility.Visible;
 sampleTextBlock.Text = "Sling";
 }
 // end sling method
 // ======================================================================

 // ======================================================================
 // method to display sample day pack
 private void dayButton_Click(object sender, RoutedEventArgs e)
 {
 sampleImage.Visibility = Visibility.Visible;
 sampleImage.Source = new BitmapImage(new Uri("ms-appx:///Assets/day.jpg"));
 sampleTextBlock.Visibility = Visibility.Visible;
 sampleTextBlock.Text = "Day";
 }
 // end day method
 // ======================================================================

 // ======================================================================
 // method to display sample hiking pack
 private void hikingButton_Click(object sender, RoutedEventArgs e)
 {
 sampleImage.Visibility = Visibility.Visible;
 sampleImage.Source = new BitmapImage(new Uri("ms-appx:///Assets/hiking.jpg"));
 sampleTextBlock.Visibility = Visibility.Visible;
 sampleTextBlock.Text = "Hiking";

// end hiking method
// ======================================================================
// ======================================================================
// method to display sample cycling pack
private void cyclingButton_Click(object sender, RoutedEventArgs e)
{
sampleImage.Visibility = Visibility.Visible;
sampleImage.Source = new BitmapImage(new Uri("ms-appx:///Assets/cycling.jpg"));
sampleTextBlock.Visibility = Visibility.Visible;
 sampleTextBlock.Text = "Cycling";
 }
 // end cycling method
 // ======================================================================

 // ======================================================================
 // method to clear form
 private void clearButton_Click(object sender, RoutedEventArgs e)
 {
 sampleImage.Visibility = Visibility.Collapsed;
 sampleTextBlock.Visibility = Visibility.Collapsed;
 }
 // end clear form method
 // ======================================================================

 } // end MainPage Class
 } // end namespace BratPack
          