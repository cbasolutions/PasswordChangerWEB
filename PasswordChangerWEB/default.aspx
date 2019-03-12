<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="PasswordChangerWEB._default" %>
<!--
  Name                : PasswordChangerWEB
  Version             : 20130808
  Author              : Luke Voorn
  Description         : Change the password of an (expired) user.
  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <link rel="stylesheet" href="/assets/bootstrap.min.css">
    <title>Change Password</title>
    <style>
      .bd-placeholder-img {
      font-size: 1.125rem;
      text-anchor: middle;
      -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
      }
      @media (min-width: 768px) {
      .bd-placeholder-img-lg {
      font-size: 3.5rem;
      }
      }
    </style>
    <!-- Custom styles for this template -->
    <link href="/assets/signin.css" rel="stylesheet">
  </head>
  <body class="text-center">
    <form id="form1" runat="server" class="form-signin">
      <img class="mb-4" src="/assets/logo.png" alt="" height="72">
      <h1 class="h3 mb-3 font-weight-normal">Change Domain Password</h1>
      <asp:Label ID="lblError" runat="server" CssClass="sr-only"></asp:Label>
      <asp:Label ID="lblUser" runat="server" CssClass="sr-only">Username</asp:Label>
      <asp:TextBox ID="txtUser" runat="server" class="form-control" placeholder="User Name" required></asp:TextBox>
      <asp:RequiredFieldValidator runat="server" ID="rqtxtUser" ErrorMessage="Please enter a username" ControlToValidate="txtUser"></asp:RequiredFieldValidator>
      <asp:Label ID="lblOldPass" runat="server" CssClass="sr-only">Old Password</asp:Label>
      <asp:TextBox ID="txtOldPass" runat="server" TextMode="Password" class="form-control" placeholder="Current Password" required></asp:TextBox>
      <asp:RequiredFieldValidator runat="server" ID="rqtxtOldPass" ErrorMessage="Password required!" ControlToValidate="txtOldPass"></asp:RequiredFieldValidator>
      <asp:Label ID="lblNewPass1" runat="server" CssClass="sr-only">New Password</asp:Label>
      <asp:TextBox ID="txtNewPass1" runat="server" TextMode="Password" class="form-control" placeholder="New Password" required></asp:TextBox>
      <asp:RequiredFieldValidator runat="server" ID="rqtxtNewPass" ErrorMessage="Password required!" ControlToValidate="txtNewPass1" Display="Dynamic" ></asp:RequiredFieldValidator>
      <asp:RegularExpressionValidator runat="server" ID="retxtNewPass1" ControlToValidate="txtNewPass1" Display="Dynamic" ErrorMessage="The new password is not strong enough" ValidationExpression="^[a-zA-Z0-9 ~!@#$%^&*_\-+=`|\(){}\[\]:;'<>,.?/]{8,50}$"></asp:RegularExpressionValidator>
      <asp:Label ID="lblNewPass2" runat="server" CssClass="sr-only">New Password Again</asp:Label>
      <asp:TextBox ID="txtNewPass2" runat="server" TextMode="Password" class="form-control" placeholder="Confirm New Password" required></asp:TextBox>
      <asp:RequiredFieldValidator runat="server" ID="rqtxtNewPass2" ErrorMessage="Wachtwoord verplicht!" Display="Dynamic" ControlToValidate="txtNewPass2"></asp:RequiredFieldValidator>
      <asp:CompareValidator runat="server" ID="cvtxtNewPass2" ErrorMessage="The passwords do not match" Display="Dynamic" ControlToValidate="txtNewPass2" ControlToCompare="txtNewPass1"></asp:CompareValidator>
      <asp:Button CssClass="btn btn-lg btn-primary btn-block" runat="server" ID="btnSubmit" onclick="btnSubmit_Click" Text="Change"/>
    </form>
  </body>
</html>