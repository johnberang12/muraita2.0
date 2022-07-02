enum PAGES {
  onboarding,
  welcome,
  registration,
  home,
  error,
  product,
  leaveReview,
  productSearch,
  addProduct,
  notifications,
  account,
  neighborhood,
  chats,
}

extension PageExtention on PAGES {
  String get toPath {
    switch (this) {
      case PAGES.home:
        return '/';
      case PAGES.onboarding:
        return 'onbording';
      case PAGES.welcome:
        return 'welcome';
      case PAGES.registration:
        return 'registration';
      case PAGES.error:
        return 'error';
      case PAGES.product:
        return 'product/:id';
      case PAGES.leaveReview:
        return 'review';
      case PAGES.productSearch:
        return 'search';
      case PAGES.addProduct:
        return 'addproduct';
      case PAGES.notifications:
        return 'notifications';
      case PAGES.account:
        return 'account';
      case PAGES.neighborhood:
        return 'neighborhood';
      case PAGES.chats:
        return 'chats';
    }
  }

  // String get toName {
  //   switch (this) {
  //     case PAGES.home:
  //       return 'HOME';
  //     case PAGES.onboarding:
  //       return 'ONBOARDING';
  //     case PAGES.login:
  //       return 'WELCOME';
  //     case PAGES.error:
  //       return 'ERROR';
  //       case PAGES.productList:return '/productList';
  //       case PAGES.leaveReview: return 'review';
  //       case PAGES.productSearch: return 'search';
  //       case PAGES.addProduct: return 'addproduct';
  //       case PAGES.notifications: return 'notifications';
  //       case PAGES.account: return 'account';
  //       case PAGES.neighborhood: return 'neighborhood';
  //       case PAGES.chats: return 'chats';
  //   }
  // }
}
