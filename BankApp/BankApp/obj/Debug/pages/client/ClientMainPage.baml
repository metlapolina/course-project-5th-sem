   M S B A M L   `   `   `  ����B  >BankApp, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:BankApp.pagesBankApp.pages  5      "    BankApp.pages.ClientMainPage   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      -localclr-namespace:BankApp.pages     5      U QMaterialDesignThemes.Wpf, Version=2.6.0.325, Culture=neutral, PublicKeyToken=nullFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5        N� 
FontFamily$  Century Gothic)�5	   0    N� FontSize$ 23(�6L    N� Title$ ClientMainPage��5
      .��5      �  � ColumnDefinitions 5   
   �� 5      $	��250 �6   �� 5      $	��600 �6    � RowDefinitions 5   
   �� 5      $��* �6   �� 5      $��7* �6   .+�5   
   �� -   5        $��
ВЫЙТИ��5      $��0��69   $��0��6I   $
��Bold"�6V   $��40��6h   $	��150��6t   $��18(�6�   
�������
�������$
��20 0q�6�   �� 5   
   -   5         ��Name$ 
tb_Welcome��5      $��1��6(   $��0��68   $'��!Добро пожаловать, ��6E   
�������$��Center=�6q   $��Center=�6�   � 5   
   $��0��6   $��1��6   .+�5      o�  o� 
IsMainMenu . $��20(�6%   $
��Bold"�63   $��Century Gothic)�6E   
���P��
���������5      �� 5      .R�5      $�  $� Orientation$ Vertical=�61   5       .@�5"      m� -   5        $��
СЧЕТА��5"      $��10 30q�6*    � Cursor$
 Hand��6U   m� 5#      -   5        $��ОПЕРАЦИИ��5#      $��10 30 -20 30q�6-   $
 Hand��6Z   m� 5$      -   5        $��КРЕДИТЫ��5$      $��10 30q�6,   $
 Hand��6P   m� 5%      -   5        $#��ПЕРЕВОД СРЕДСТВ��5%      $��10 30 -200 30q�64   $
 Hand��6_   m� 5&      -   5        $��ТРАНЗАКЦИИ��5&      $��10 30 -50 30q�6/   $
 Hand��6^   5'      5(      �� 5)   
   $��0��6   � 5+   
   $��1��6   $��1��6   .+�5,       � -   5        	  �Name$	 ClientFrame��5,      
  � NavigationUIVisibility$
 Hidden=�6)   5-      5.      5/      