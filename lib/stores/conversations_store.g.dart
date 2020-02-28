// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversations_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConversationsStore on _ConversationsStore, Store {
  final _$conversationsAtom = Atom(name: '_ConversationsStore.conversations');

  @override
  ObservableList<Conversation> get conversations {
    _$conversationsAtom.context.enforceReadPolicy(_$conversationsAtom);
    _$conversationsAtom.reportObserved();
    return super.conversations;
  }

  @override
  set conversations(ObservableList<Conversation> value) {
    _$conversationsAtom.context.conditionallyRunInAction(() {
      super.conversations = value;
      _$conversationsAtom.reportChanged();
    }, _$conversationsAtom, name: '${_$conversationsAtom.name}_set');
  }

  final _$selectedConversationAtom =
      Atom(name: '_ConversationsStore.selectedConversation');

  @override
  Conversation get selectedConversation {
    _$selectedConversationAtom.context
        .enforceReadPolicy(_$selectedConversationAtom);
    _$selectedConversationAtom.reportObserved();
    return super.selectedConversation;
  }

  @override
  set selectedConversation(Conversation value) {
    _$selectedConversationAtom.context.conditionallyRunInAction(() {
      super.selectedConversation = value;
      _$selectedConversationAtom.reportChanged();
    }, _$selectedConversationAtom,
        name: '${_$selectedConversationAtom.name}_set');
  }

  final _$_ConversationsStoreActionController =
      ActionController(name: '_ConversationsStore');

  @override
  void addNewConversation(Conversation conversation) {
    final _$actionInfo = _$_ConversationsStoreActionController.startAction();
    try {
      return super.addNewConversation(conversation);
    } finally {
      _$_ConversationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedConversation(int conversationId) {
    final _$actionInfo = _$_ConversationsStoreActionController.startAction();
    try {
      return super.changeSelectedConversation(conversationId);
    } finally {
      _$_ConversationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendMessage(Message message) {
    final _$actionInfo = _$_ConversationsStoreActionController.startAction();
    try {
      return super.sendMessage(message);
    } finally {
      _$_ConversationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'conversations: ${conversations.toString()},selectedConversation: ${selectedConversation.toString()}';
    return '{$string}';
  }
}
