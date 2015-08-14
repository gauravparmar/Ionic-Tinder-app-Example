(->
  "use strict"
  DashCtrl = ->
    return

  ChatsCtrl = (Chats) ->
    # Use ViewModel instead of scope
    vm = @
    vm.chats = Chats.all()
    vm.remove = (chat) ->
      Chats.remove chat
      return
    return

  ChatDetailCtrl = ($stateParams, Chats) ->
    vm = @
    vm.chat = Chats.get $stateParams.chatId
    return

  AccountCtrl = ->
    vm = @
    vm.settings = {
      enableFriends: true
    }
    return

  TinderCtrl = (Cards, TDCardDelegate, $ionicSlideBoxDelegate, Modals) ->
    disableSwipe = ->
      $ionicSlideBoxDelegate.enableSlide(false)
      return

    enableSwipe = ->
      $ionicSlideBoxDelegate.enableSlide(true)
      return

    cardIsLiked = (index) ->
      console.log "LIKE!" + index
      return

    cardIsDisliked = (index) ->
      console.log "NOPE" + index
      return

    vm = @
    vm.cards  = Cards.all()

    vm.onTouch = ->
      disableSwipe()
      return

    vm.onRelease = ->
      enableSwipe()
      return

    vm.cardDestroyed = (index) ->
      vm.cards.splice index, 1
      return

    vm.cardSwipedLeft = (index) ->
      cardIsDisliked(index)
      return

    vm.cardSwipedRight = (index) ->
      cardIsLiked(index)
      return

    vm.cardTapNo = ->
      cardIsDisliked(0)
      vm.cardDestroyed(0)
      return

    vm.cardTapYes = ->
      cardIsLiked(0)
      vm.cardDestroyed(0)
      return

    vm.openCardModal = (card) ->
      if card
        Modals.showCardItem(card)
        .then(
          (card) ->
            vm.card = card
        )
      return

    vm.closeCardModal = (result) ->
      if result
        vm.closeModal(result)
      return

    return

  TinderModalCtrl = (parameters, Modals) ->
    vm = @
    vm.card = parameters

    vm.closeCardModal = (result) ->
      if result
        vm.closeModal(result)
      return

    return

  angular
    .module("starter")
    .controller("DashCtrl", DashCtrl)
    .controller("TinderCtrl", TinderCtrl)
    .controller("TinderModalCtrl", TinderModalCtrl)
    .controller("ChatsCtrl", ChatsCtrl)
    .controller("ChatDetailCtrl", ChatDetailCtrl)
    .controller("AccountCtrl", AccountCtrl)
)()
