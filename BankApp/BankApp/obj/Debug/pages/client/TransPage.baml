   M S B A M L   `   `   `  ����B  >BankApp, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null;"clr-namespace:BankApp.pages.clientBankApp.pages.client  5      $    BankApp.pages.client.TransPage   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      4local"clr-namespace:BankApp.pages.client     5      U QMaterialDesignThemes.Wpf, Version=2.6.0.325, Culture=neutral, PublicKeyToken=nullFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5        N� 
FontFamily$  Century Gothic)�5	   0    N� FontSize$ 25(�6L    N� Title$ 	TransPage��5
      .��5      �� $��	10 0 10 0q�6   .+�5   
   �� $#��ПЕРЕВОД СРЕДСТВ��6   $��Center=�6+   $
��0 40q�6H   
���P��$
��Bold"�6i   ]� 5   
   $	��300��6   $��	0 10 0 10q�6    .+�5      '  !MaterialDesignThemes.Wpf.PackIcon  �  �ControlzEx.PackIconBase`1[[MaterialDesignThemes.Wpf.PackIconKind, MaterialDesignThemes.Wpf, Version=2.6.0.325, Culture=neutral, PublicKeyToken=null]]   Kind$
 Bank=�6&   
�������$��35��6E   $��35��6P   �� 5      -   5         ��Name$ cb_FromAccount��5      )  #MaterialDesignThemes.Wpf.HintAssist   Hint$ Со счета��6/   $	��5 0q�6Y   $��35��6g   $��16(�6s   $��Center=�6�   5      ]� 5   
   $	��300��6   $��	0 10 0 15q�6    .+�5        $ AccountBalanceWallet=�6&   
�������$��0q�6T   $��35��6`   $��35��6k   �� 5      -   5         ��Name$ txt_Balance��5      $��16(�6+   $ 
Сумма��69    �� 	MaxLength$ 10��6`   $	��5 0q�6o   $��35��6}   $��Center=�6�   5      ]� 5   
   $	��300��6   $��	0 10 0 20q�6    .+�5        $
 Bank=�6&   
�������$��35��6E   $��35��6P   �� 5      -   5        $ txt_ToAccount��5      $ На счет��6-   $	��5 0q�6V   $��35��6d   $��16(�6p   $��Center=�6   5      �� 5   
   -   5        $+��%В рамках одного лица��5      $	��280��60   $��45��6<   $��18(�6H   
�������
���P��$��10q�6|   6�   �� 5   
   -   5        $��Другому лицу��5      $	��280��6(   $��45��64   $��18(�6@   
�������
���P��$��10q�6t   6�   �� 5   
   -   5        $$��С обменом валюты��5      $	��280��6,   $��45��68   $��18(�6D   
�������
���P��$��10q�6x   6�   5      5      