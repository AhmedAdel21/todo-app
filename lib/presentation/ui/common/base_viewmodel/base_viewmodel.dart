abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {}

abstract class BaseViewModelInputs {
  void start(); // start view model job
  void destroy(); // will be called when view model dies

}

abstract class BaseViewModelOutputs {}
