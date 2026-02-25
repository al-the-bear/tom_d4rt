// D4rt Bridge - Generated file, do not edit
// Sources: 41 files
// Generated: 2026-02-15T00:34:33.991686

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:http/src/base_request.dart' as $http_1;
import 'package:http/src/client.dart' as $http_2;
import 'package:http/src/request.dart' as $http_3;
import 'package:http/src/streamed_response.dart' as $http_4;
import 'package:timezone/src/date_time.dart' as $timezone_1;
import 'package:timezone/src/location.dart' as $timezone_2;
import 'package:tom_basics/src/exception_base.dart' as $tom_basics_1;
import 'package:tom_basics/src/logging/logging.dart' as $tom_basics_2;
import 'package:tom_basics/src/runtime/platform_environment_runtime.dart' as $tom_basics_3;
import 'package:tom_basics/src/runtime/platform_neutral.dart' as $tom_basics_4;
import 'package:tom_core_kernel/src/tombase/beanlocator/bean_locator.dart' as $tom_core_kernel_1;
import 'package:tom_core_kernel/src/tombase/context/execution_context.dart' as $tom_core_kernel_2;
import 'package:tom_core_kernel/src/tombase/http_connection/endpoints_apis.dart' as $tom_core_kernel_3;
import 'package:tom_core_kernel/src/tombase/http_connection/headers.dart' as $tom_core_kernel_4;
import 'package:tom_core_kernel/src/tombase/http_connection/httpmethods.dart' as $tom_core_kernel_5;
import 'package:tom_core_kernel/src/tombase/http_connection/mimetypes.dart' as $tom_core_kernel_6;
import 'package:tom_core_kernel/src/tombase/http_connection/remote_context.dart' as $tom_core_kernel_7;
import 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart' as $tom_core_kernel_8;
import 'package:tom_core_kernel/src/tombase/isolate_pooling/tom_worker.dart' as $tom_core_kernel_9;
import 'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart' as $tom_core_kernel_10;
import 'package:tom_core_kernel/src/tombase/json/pretty_json.dart' as $tom_core_kernel_11;
import 'package:tom_core_kernel/src/tombase/little_things/exception_base.dart' as $tom_core_kernel_12;
import 'package:tom_core_kernel/src/tombase/little_things/formatting.dart' as $tom_core_kernel_13;
import 'package:tom_core_kernel/src/tombase/little_things/little_things.dart' as $tom_core_kernel_14;
import 'package:tom_core_kernel/src/tombase/logging/logging_isolate.dart' as $tom_core_kernel_15;
import 'package:tom_core_kernel/src/tombase/logging/remote_logoutput.dart' as $tom_core_kernel_16;
import 'package:tom_core_kernel/src/tombase/logging/remote_logserver.dart' as $tom_core_kernel_17;
import 'package:tom_core_kernel/src/tombase/observable/tom_observable.dart' as $tom_core_kernel_18;
import 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart' as $tom_core_kernel_19;
import 'package:tom_core_kernel/src/tombase/reflection/reflection.dart' as $tom_core_kernel_20;
import 'package:tom_core_kernel/src/tombase/resources/tom_resource_provider.dart' as $tom_core_kernel_21;
import 'package:tom_core_kernel/src/tombase/security/access_controls.dart' as $tom_core_kernel_22;
import 'package:tom_core_kernel/src/tombase/security/authentication_authorization.dart' as $tom_core_kernel_23;
import 'package:tom_core_kernel/src/tombase/security/bearer_authentication.dart' as $tom_core_kernel_24;
import 'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart' as $tom_core_kernel_25;
import 'package:tom_core_kernel/src/tombase/settings/settings_client_authorization.dart' as $tom_core_kernel_26;
import 'package:tom_core_kernel/src/tombase/shutdown_cleanup/tom_shutdown_cleanup.dart' as $tom_core_kernel_27;
import 'package:tom_core_kernel/src/tombase/timezoned/date_timestamp.dart' as $tom_core_kernel_28;
import 'package:tom_core_kernel/src/tombase/timezoned/timezones.dart' as $tom_core_kernel_29;
import 'package:tom_crypto/src/jwt_token.dart' as $tom_crypto_1;
import 'package:tom_crypto/src/password_hashing.dart' as $tom_crypto_2;
import 'package:tom_crypto/src/rsa_encryption.dart' as $tom_crypto_3;
import 'package:tom_crypto/src/rsa_tools.dart' as $tom_crypto_4;
import 'package:tom_reflection/src/reflection/capability.dart' as $tom_reflection_1;
import 'package:tom_reflection/src/reflection/mirrors.dart' as $tom_reflection_2;
import 'package:tom_reflection/src/reflection/reflection_builder_based.dart' as $tom_reflection_3;
import 'package:tom_reflection/tom_reflection.dart' as $tom_reflection_4;

/// Bridge class for tom_core_kernel module.
class TomCoreKernelBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createTomBaseExceptionBridge(),
      _createTomLogLevelBridge(),
      _createTomLoggerBridge(),
      _createTomLoggableBridge(),
      _createTomLogOutputBridge(),
      _createTomConsoleLogOutputBridge(),
      _createTomPlatformUtilsBridge(),
      _createTomFallbackPlatformUtilsBridge(),
      _createTomEnvironmentBridge(),
      _createTomPlatformBridge(),
      _createTomRuntimeBridge(),
      _createTomJwtTokenExceptionBridge(),
      _createTomJwtConfigurationBridge(),
      _createTomServerJwtTokenBridge(),
      _createTomClientJwtTokenBridge(),
      _createTomPasswordHasherBridge(),
      _createRsaKeyHelperBridge(),
      _createTomBeanLocatorExceptionBridge(),
      _createTomComponentBridge(),
      _createTomNullInterfaceBridge(),
      _createTomNoInterfaceBridge(),
      _createTomBeanBridge(),
      _createTomExecutionContextBridge(),
      _createTomZoneValuesBridge(),
      _createTomContextEntryBridge(),
      _createTomContextProvidersBridge(),
      _createTomServerConnectionExceptionBridge(),
      _createTomRequestAbortedExceptionBridge(),
      _createTomServerCallSpecsBridge(),
      _createTomServerCallLoadBridge(),
      _createTomServerCallErrorBridge(),
      _createTomServerCallBridge(),
      _createTomServerChannelBridge(),
      _createTomHttpClientFactoryBridge(),
      _createTomHttpClientAbstractFactoryBridge(),
      _createTomDefaultHttpClientFactoryBridge(),
      _createTomServerEndpointBridge(),
      _createTomEndpointExceptionBridge(),
      _createTomContentDispositionBridge(),
      _createTomRemoteApisBridge(),
      _createTomApiBridge(),
      _createTomApiEndpointBridge(),
      _createTomClientRemoteContextExceptionBridge(),
      _createTomClientRemoteContextBridge(),
      _createTomHttpMethodBridge(),
      _createTomMimeTypeExceptionBridge(),
      _createTomMimeTypeBridge(),
      _createStaticFileMimetypeMappingBridge(),
      _createTomHeaderBridge(),
      _createTomWorkerExceptionBridge(),
      _createTomExecutorBridge(),
      _createTomCommandBridge(),
      _createTomWorkerContextBridge(),
      _createTomWorkerBridge(),
      _createTomWorkerPoolBridge(),
      _createTomExceptionBridge(),
      _createTomLoggingExecutorBridge(),
      _createTomInterIsolateLogMessageBridge(),
      _createTomIsolateLogOutputBridge(),
      _createTomCreatorLogOutputBridge(),
      _createTomLoggingWorkerContextBridge(),
      _createTomIsolateLoggingBridge(),
      _createTomRemoteLogMessageBridge(),
      _createTomRemoteLogResultBridge(),
      _createTomLoggingContextBridge(),
      _createTomRemoteLogOutputBridge(),
      _createTomRemoteLogServerBridge(),
      _createTomTextResourceProviderBridge(),
      _createTomConfigResourceProviderBridge(),
      _createTomResourceKeyProtectionBridge(),
      _createTomAccessControlBridge(),
      _createTomNoAccessBridge(),
      _createTomPublicAccessBridge(),
      _createTomAuthenticatedAccessBridge(),
      _createTomGuestAccessBridge(),
      _createTomCustomAccessBridge(),
      _createTomEntitlementAccessBridge(),
      _createTomRoleAccessBridge(),
      _createTomGroupAccessBridge(),
      _createTomResourceKeyAccessBridge(),
      _createTomAuthenticationMessageBridge(),
      _createTomAuthenticationResultBridge(),
      _createTomBearerAuthenticationBridge(),
      _createTomAccessControlInformationBridge(),
      _createTomClientLimitsInformationBridge(),
      _createTomAccessControlDefinitionBridge(),
      _createTomGroupBridge(),
      _createTomRoleBridge(),
      _createTomEntitlementBridge(),
      _createTomUserBridge(),
      _createTomPrincipalBridge(),
      _createTomGetSettingsMessageBridge(),
      _createTomGetSettingsResultBridge(),
      _createTomDisposableBridge(),
      _createTomClosableBridge(),
      _createTomCloseAdaptorBridge(),
      _createTomShutdownCleanupBridge(),
      _createTomObservableBridge(),
      _createTomObserverBridge(),
      _createTomFunctionObserverBridge(),
      _createTomReflectorExceptionBridge(),
      _createTomReflectorBridge(),
      _createTomReflectionInfoBridge(),
      _createTomObservableExceptionBridge(),
      _createTomObjectBridge(),
      _createTomStringBridge(),
      _createTomIntBridge(),
      _createTomDoubleBridge(),
      _createTomBoolBridge(),
      _createTomDateTimeBridge(),
      _createTomOTimezonedBridge(),
      _createTomOZonedTimeBridge(),
      _createTomOZonedDateBridge(),
      _createTomOZonedDateTimeBridge(),
      _createTomNStringBridge(),
      _createTomNIntBridge(),
      _createTomNDoubleBridge(),
      _createTomNBoolBridge(),
      _createTomNDateTimeBridge(),
      _createTomNOTimezonedBridge(),
      _createTomNOZonedTimeBridge(),
      _createTomNOZonedDateBridge(),
      _createTomNOZonedDateTimeBridge(),
      _createTomDateRangeBridge(),
      _createTomTimeRangeBridge(),
      _createTomDateTimeRangeBridge(),
      _createTomClassBridge(),
      _createTomListBridge(),
      _createTomMapBridge(),
      _createTomTimezonedBridge(),
      _createTomZonedDateBridge(),
      _createTomZonedTimeBridge(),
      _createTomZonedDateTimeBridge(),
      _createTomTimezoneExceptionBridge(),
      _createTomTimezoneBridge(),
      _createReflectCapabilityBridge(),
      _createApiReflectCapabilityBridge(),
      _createNamePatternCapabilityBridge(),
      _createMetadataQuantifiedCapabilityBridge(),
      _createInstanceInvokeCapabilityBridge(),
      _createInstanceInvokeMetaCapabilityBridge(),
      _createStaticInvokeCapabilityBridge(),
      _createStaticInvokeMetaCapabilityBridge(),
      _createTopLevelInvokeCapabilityBridge(),
      _createTopLevelInvokeMetaCapabilityBridge(),
      _createNewInstanceCapabilityBridge(),
      _createNewInstanceMetaCapabilityBridge(),
      _createMetadataCapabilityBridge(),
      _createTypeCapabilityBridge(),
      _createTypeRelationsCapabilityBridge(),
      _createLibraryCapabilityBridge(),
      _createDeclarationsCapabilityBridge(),
      _createUriCapabilityBridge(),
      _createLibraryDependenciesCapabilityBridge(),
      _createInvokingCapabilityBridge(),
      _createInvokingMetaCapabilityBridge(),
      _createTypingCapabilityBridge(),
      _createReflecteeQuantifyCapabilityBridge(),
      _createSuperclassQuantifyCapabilityBridge(),
      _createTypeAnnotationQuantifyCapabilityBridge(),
      _createImportAttachedCapabilityBridge(),
      _createGlobalQuantifyCapabilityBridge(),
      _createGlobalQuantifyMetaCapabilityBridge(),
      _createNoSuchCapabilityErrorBridge(),
      _createReflectionNoSuchMethodErrorBridge(),
      _createMirrorBridge(),
      _createDeclarationMirrorBridge(),
      _createObjectMirrorBridge(),
      _createInstanceMirrorBridge(),
      _createClosureMirrorBridge(),
      _createLibraryMirrorBridge(),
      _createLibraryDependencyMirrorBridge(),
      _createCombinatorMirrorBridge(),
      _createTypeMirrorBridge(),
      _createClassMirrorBridge(),
      _createFunctionTypeMirrorBridge(),
      _createTypeVariableMirrorBridge(),
      _createTypedefMirrorBridge(),
      _createMethodMirrorBridge(),
      _createVariableMirrorBridge(),
      _createParameterMirrorBridge(),
      _createSourceLocationBridge(),
      _createCommentBridge(),
      _createTypeValueBridge(),
      _createReflectionInterfaceBridge(),
      _createReflectionBridge(),
      _createStringInvocationBridge(),
      _createReflectorDataBridge(),
      _createNonGenericClassMirrorImplBridge(),
      _createGenericClassMirrorImplBridge(),
      _createLibraryMirrorImplBridge(),
      _createMethodMirrorImplBridge(),
      _createImplicitSetterMirrorImplBridge(),
      _createVariableMirrorImplBridge(),
      _createParameterMirrorImplBridge(),
      _createReflectionImplBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'TomBaseException': 'package:tom_basics/src/exception_base.dart',
      'TomLogLevel': 'package:tom_basics/src/logging/logging.dart',
      'TomLogger': 'package:tom_basics/src/logging/logging.dart',
      'TomLoggable': 'package:tom_basics/src/logging/logging.dart',
      'TomLogOutput': 'package:tom_basics/src/logging/logging.dart',
      'TomConsoleLogOutput': 'package:tom_basics/src/logging/logging.dart',
      'TomPlatformUtils': 'package:tom_basics/src/runtime/platform_neutral.dart',
      'TomFallbackPlatformUtils': 'package:tom_basics/src/runtime/platform_neutral.dart',
      'TomEnvironment': 'package:tom_basics/src/runtime/platform_environment_runtime.dart',
      'TomPlatform': 'package:tom_basics/src/runtime/platform_environment_runtime.dart',
      'TomRuntime': 'package:tom_basics/src/runtime/platform_environment_runtime.dart',
      'TomJwtTokenException': 'package:tom_crypto/src/jwt_token.dart',
      'TomJwtConfiguration': 'package:tom_crypto/src/jwt_token.dart',
      'TomServerJwtToken': 'package:tom_crypto/src/jwt_token.dart',
      'TomClientJwtToken': 'package:tom_crypto/src/jwt_token.dart',
      'TomPasswordHasher': 'package:tom_crypto/src/password_hashing.dart',
      'RsaKeyHelper': 'package:tom_crypto/src/rsa_tools.dart',
      'TomBeanLocatorException': 'package:tom_core_kernel/src/tombase/beanlocator/bean_locator.dart',
      'TomComponent': 'package:tom_core_kernel/src/tombase/beanlocator/bean_locator.dart',
      'TomNullInterface': 'package:tom_core_kernel/src/tombase/beanlocator/bean_locator.dart',
      'TomNoInterface': 'package:tom_core_kernel/src/tombase/beanlocator/bean_locator.dart',
      'TomBean': 'package:tom_core_kernel/src/tombase/beanlocator/bean_locator.dart',
      'TomExecutionContext': 'package:tom_core_kernel/src/tombase/context/execution_context.dart',
      'TomZoneValues': 'package:tom_core_kernel/src/tombase/context/execution_context.dart',
      'TomContextEntry': 'package:tom_core_kernel/src/tombase/context/execution_context.dart',
      'TomContextProviders': 'package:tom_core_kernel/src/tombase/context/execution_context.dart',
      'TomServerConnectionException': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomRequestAbortedException': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomServerCallSpecs': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomServerCallLoad': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomServerCallError': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomServerCall': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomServerChannel': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomHttpClientFactory': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomHttpClientAbstractFactory': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomDefaultHttpClientFactory': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomServerEndpoint': 'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'TomEndpointException': 'package:tom_core_kernel/src/tombase/http_connection/endpoints_apis.dart',
      'TomContentDisposition': 'package:tom_core_kernel/src/tombase/http_connection/endpoints_apis.dart',
      'TomRemoteApis': 'package:tom_core_kernel/src/tombase/http_connection/endpoints_apis.dart',
      'TomApi': 'package:tom_core_kernel/src/tombase/http_connection/endpoints_apis.dart',
      'TomApiEndpoint': 'package:tom_core_kernel/src/tombase/http_connection/endpoints_apis.dart',
      'TomClientRemoteContextException': 'package:tom_core_kernel/src/tombase/http_connection/remote_context.dart',
      'TomClientRemoteContext': 'package:tom_core_kernel/src/tombase/http_connection/remote_context.dart',
      'TomHttpMethod': 'package:tom_core_kernel/src/tombase/http_connection/httpmethods.dart',
      'TomMimeTypeException': 'package:tom_core_kernel/src/tombase/http_connection/mimetypes.dart',
      'TomMimeType': 'package:tom_core_kernel/src/tombase/http_connection/mimetypes.dart',
      'StaticFileMimetypeMapping': 'package:tom_core_kernel/src/tombase/http_connection/mimetypes.dart',
      'TomHeader': 'package:tom_core_kernel/src/tombase/http_connection/headers.dart',
      'TomWorkerException': 'package:tom_core_kernel/src/tombase/isolate_pooling/tom_worker.dart',
      'TomExecutor': 'package:tom_core_kernel/src/tombase/isolate_pooling/tom_worker.dart',
      'TomCommand': 'package:tom_core_kernel/src/tombase/isolate_pooling/tom_worker.dart',
      'TomWorkerContext': 'package:tom_core_kernel/src/tombase/isolate_pooling/tom_worker.dart',
      'TomWorker': 'package:tom_core_kernel/src/tombase/isolate_pooling/tom_worker.dart',
      'TomWorkerPool': 'package:tom_core_kernel/src/tombase/isolate_pooling/tom_worker.dart',
      'TomException': 'package:tom_core_kernel/src/tombase/little_things/exception_base.dart',
      'TomLoggingExecutor': 'package:tom_core_kernel/src/tombase/logging/logging_isolate.dart',
      'TomInterIsolateLogMessage': 'package:tom_core_kernel/src/tombase/logging/logging_isolate.dart',
      'TomIsolateLogOutput': 'package:tom_core_kernel/src/tombase/logging/logging_isolate.dart',
      'TomCreatorLogOutput': 'package:tom_core_kernel/src/tombase/logging/logging_isolate.dart',
      'TomLoggingWorkerContext': 'package:tom_core_kernel/src/tombase/logging/logging_isolate.dart',
      'TomIsolateLogging': 'package:tom_core_kernel/src/tombase/logging/logging_isolate.dart',
      'TomRemoteLogMessage': 'package:tom_core_kernel/src/tombase/logging/remote_logoutput.dart',
      'TomRemoteLogResult': 'package:tom_core_kernel/src/tombase/logging/remote_logoutput.dart',
      'TomLoggingContext': 'package:tom_core_kernel/src/tombase/logging/remote_logoutput.dart',
      'TomRemoteLogOutput': 'package:tom_core_kernel/src/tombase/logging/remote_logoutput.dart',
      'TomRemoteLogServer': 'package:tom_core_kernel/src/tombase/logging/remote_logserver.dart',
      'TomTextResourceProvider': 'package:tom_core_kernel/src/tombase/resources/tom_resource_provider.dart',
      'TomConfigResourceProvider': 'package:tom_core_kernel/src/tombase/resources/tom_resource_provider.dart',
      'TomResourceKeyProtection': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomAccessControl': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomNoAccess': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomPublicAccess': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomAuthenticatedAccess': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomGuestAccess': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomCustomAccess': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomEntitlementAccess': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomRoleAccess': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomGroupAccess': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomResourceKeyAccess': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'TomAuthenticationMessage': 'package:tom_core_kernel/src/tombase/security/authentication_authorization.dart',
      'TomAuthenticationResult': 'package:tom_core_kernel/src/tombase/security/authentication_authorization.dart',
      'TomBearerAuthentication': 'package:tom_core_kernel/src/tombase/security/bearer_authentication.dart',
      'TomAccessControlInformation': 'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart',
      'TomClientLimitsInformation': 'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart',
      'TomAccessControlDefinition': 'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart',
      'TomGroup': 'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart',
      'TomRole': 'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart',
      'TomEntitlement': 'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart',
      'TomUser': 'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart',
      'TomPrincipal': 'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart',
      'TomGetSettingsMessage': 'package:tom_core_kernel/src/tombase/settings/settings_client_authorization.dart',
      'TomGetSettingsResult': 'package:tom_core_kernel/src/tombase/settings/settings_client_authorization.dart',
      'TomDisposable': 'package:tom_core_kernel/src/tombase/shutdown_cleanup/tom_shutdown_cleanup.dart',
      'TomClosable': 'package:tom_core_kernel/src/tombase/shutdown_cleanup/tom_shutdown_cleanup.dart',
      'TomCloseAdaptor': 'package:tom_core_kernel/src/tombase/shutdown_cleanup/tom_shutdown_cleanup.dart',
      'TomShutdownCleanup': 'package:tom_core_kernel/src/tombase/shutdown_cleanup/tom_shutdown_cleanup.dart',
      'TomObservable': 'package:tom_core_kernel/src/tombase/observable/tom_observable.dart',
      'TomObserver': 'package:tom_core_kernel/src/tombase/observable/tom_observable.dart',
      'TomFunctionObserver': 'package:tom_core_kernel/src/tombase/observable/tom_observable.dart',
      'TomReflectorException': 'package:tom_core_kernel/src/tombase/reflection/reflection.dart',
      'TomReflector': 'package:tom_core_kernel/src/tombase/reflection/reflection.dart',
      'TomReflectionInfo': 'package:tom_core_kernel/src/tombase/reflection/reflection.dart',
      'TomObservableException': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomObject': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomString': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomInt': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomDouble': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomBool': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomDateTime': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomOTimezoned': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomOZonedTime': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomOZonedDate': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomOZonedDateTime': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomNString': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomNInt': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomNDouble': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomNBool': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomNDateTime': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomNOTimezoned': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomNOZonedTime': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomNOZonedDate': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomNOZonedDateTime': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomDateRange': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomTimeRange': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomDateTimeRange': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomClass': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomList': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomMap': 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'TomTimezoned': 'package:tom_core_kernel/src/tombase/timezoned/date_timestamp.dart',
      'TomZonedDate': 'package:tom_core_kernel/src/tombase/timezoned/date_timestamp.dart',
      'TomZonedTime': 'package:tom_core_kernel/src/tombase/timezoned/date_timestamp.dart',
      'TomZonedDateTime': 'package:tom_core_kernel/src/tombase/timezoned/date_timestamp.dart',
      'TomTimezoneException': 'package:tom_core_kernel/src/tombase/timezoned/timezones.dart',
      'TomTimezone': 'package:tom_core_kernel/src/tombase/timezoned/timezones.dart',
      'ReflectCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'ApiReflectCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'NamePatternCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'MetadataQuantifiedCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'InstanceInvokeCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'InstanceInvokeMetaCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'StaticInvokeCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'StaticInvokeMetaCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'TopLevelInvokeCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'TopLevelInvokeMetaCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'NewInstanceCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'NewInstanceMetaCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'MetadataCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'TypeCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'TypeRelationsCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'LibraryCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'DeclarationsCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'UriCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'LibraryDependenciesCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'InvokingCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'InvokingMetaCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'TypingCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'ReflecteeQuantifyCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'SuperclassQuantifyCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'TypeAnnotationQuantifyCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'ImportAttachedCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'GlobalQuantifyCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'GlobalQuantifyMetaCapability': 'package:tom_reflection/src/reflection/capability.dart',
      'NoSuchCapabilityError': 'package:tom_reflection/src/reflection/capability.dart',
      'ReflectionNoSuchMethodError': 'package:tom_reflection/src/reflection/capability.dart',
      'Mirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'DeclarationMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'ObjectMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'InstanceMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'ClosureMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'LibraryMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'LibraryDependencyMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'CombinatorMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'TypeMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'ClassMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'FunctionTypeMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'TypeVariableMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'TypedefMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'MethodMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'VariableMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'ParameterMirror': 'package:tom_reflection/src/reflection/mirrors.dart',
      'SourceLocation': 'package:tom_reflection/src/reflection/mirrors.dart',
      'Comment': 'package:tom_reflection/src/reflection/mirrors.dart',
      'TypeValue': 'package:tom_reflection/src/reflection/mirrors.dart',
      'ReflectionInterface': 'package:tom_reflection/tom_reflection.dart',
      'Reflection': 'package:tom_reflection/tom_reflection.dart',
      'StringInvocation': 'package:tom_reflection/tom_reflection.dart',
      'ReflectorData': 'package:tom_reflection/src/reflection/reflection_builder_based.dart',
      'NonGenericClassMirrorImpl': 'package:tom_reflection/src/reflection/reflection_builder_based.dart',
      'GenericClassMirrorImpl': 'package:tom_reflection/src/reflection/reflection_builder_based.dart',
      'LibraryMirrorImpl': 'package:tom_reflection/src/reflection/reflection_builder_based.dart',
      'MethodMirrorImpl': 'package:tom_reflection/src/reflection/reflection_builder_based.dart',
      'ImplicitSetterMirrorImpl': 'package:tom_reflection/src/reflection/reflection_builder_based.dart',
      'VariableMirrorImpl': 'package:tom_reflection/src/reflection/reflection_builder_based.dart',
      'ParameterMirrorImpl': 'package:tom_reflection/src/reflection/reflection_builder_based.dart',
      'ReflectionImpl': 'package:tom_reflection/src/reflection/reflection_builder_based.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$tom_reflection_1.StringInvocationKind>(
        name: 'StringInvocationKind',
        values: $tom_reflection_1.StringInvocationKind.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'StringInvocationKind': 'package:tom_reflection/src/reflection/capability.dart',
    };
  }

  /// Returns all bridged extension definitions.
  static List<BridgedExtensionDefinition> bridgedExtensions() {
    return [
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
    return {
    };
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }

    // Register bridged enums with source URIs for deduplication
    final enums = bridgedEnums();
    final enumSources = enumSourceUris();
    for (final enumDef in enums) {
      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);
    }

    // Register global variables
    registerGlobalVariables(interpreter, importPath);

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('tomLog', $tom_basics_2.tomLog, importPath, sourceUri: 'package:tom_basics/src/logging/logging.dart');
    } catch (e) {
      errors.add('Failed to register variable "tomLog": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformWeb', $tom_basics_3.platformWeb, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformWeb": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformMacos', $tom_basics_3.platformMacos, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformMacos": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformWindows', $tom_basics_3.platformWindows, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformWindows": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformAndroid', $tom_basics_3.platformAndroid, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformAndroid": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformIos', $tom_basics_3.platformIos, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformIos": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformLinux', $tom_basics_3.platformLinux, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformLinux": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformFuchsia', $tom_basics_3.platformFuchsia, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformFuchsia": $e');
    }
    try {
      interpreter.registerGlobalVariable('defaultTomEnvironment', $tom_basics_3.defaultTomEnvironment, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "defaultTomEnvironment": $e');
    }
    try {
      interpreter.registerGlobalVariable('noTomEnvironment', $tom_basics_3.noTomEnvironment, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "noTomEnvironment": $e');
    }
    try {
      interpreter.registerGlobalVariable('noTomPlatform', $tom_basics_3.noTomPlatform, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "noTomPlatform": $e');
    }
    try {
      interpreter.registerGlobalVariable('tomRsaHashIdentifier', $tom_crypto_3.tomRsaHashIdentifier, importPath, sourceUri: 'package:tom_crypto/src/rsa_encryption.dart');
    } catch (e) {
      errors.add('Failed to register variable "tomRsaHashIdentifier": $e');
    }
    try {
      interpreter.registerGlobalVariable('tomComponent', $tom_core_kernel_1.tomComponent, importPath, sourceUri: 'package:tom_core_kernel/src/tombase/beanlocator/bean_locator.dart');
    } catch (e) {
      errors.add('Failed to register variable "tomComponent": $e');
    }
    try {
      interpreter.registerGlobalVariable('tomExecutionContext', $tom_core_kernel_2.tomExecutionContext, importPath, sourceUri: 'package:tom_core_kernel/src/tombase/context/execution_context.dart');
    } catch (e) {
      errors.add('Failed to register variable "tomExecutionContext": $e');
    }
    try {
      interpreter.registerGlobalVariable('indentEncoder', $tom_core_kernel_11.indentEncoder, importPath, sourceUri: 'package:tom_core_kernel/src/tombase/json/pretty_json.dart');
    } catch (e) {
      errors.add('Failed to register variable "indentEncoder": $e');
    }
    try {
      interpreter.registerGlobalVariable('tomShutdownCleanup', $tom_core_kernel_27.tomShutdownCleanup, importPath, sourceUri: 'package:tom_core_kernel/src/tombase/shutdown_cleanup/tom_shutdown_cleanup.dart');
    } catch (e) {
      errors.add('Failed to register variable "tomShutdownCleanup": $e');
    }
    try {
      interpreter.registerGlobalVariable('tomReflector', $tom_core_kernel_20.tomReflector, importPath, sourceUri: 'package:tom_core_kernel/src/tombase/reflection/reflection.dart');
    } catch (e) {
      errors.add('Failed to register variable "tomReflector": $e');
    }
    try {
      interpreter.registerGlobalVariable('tomReflectionInfo', $tom_core_kernel_20.tomReflectionInfo, importPath, sourceUri: 'package:tom_core_kernel/src/tombase/reflection/reflection.dart');
    } catch (e) {
      errors.add('Failed to register variable "tomReflectionInfo": $e');
    }
    try {
      interpreter.registerGlobalVariable('tomNull', $tom_core_kernel_19.tomNull, importPath, sourceUri: 'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart');
    } catch (e) {
      errors.add('Failed to register variable "tomNull": $e');
    }
    try {
      interpreter.registerGlobalVariable('instanceInvokeCapability', $tom_reflection_1.instanceInvokeCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "instanceInvokeCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('staticInvokeCapability', $tom_reflection_1.staticInvokeCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "staticInvokeCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('topLevelInvokeCapability', $tom_reflection_1.topLevelInvokeCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "topLevelInvokeCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('newInstanceCapability', $tom_reflection_1.newInstanceCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "newInstanceCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('metadataCapability', $tom_reflection_1.metadataCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "metadataCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('typeCapability', $tom_reflection_1.typeCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "typeCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('typeRelationsCapability', $tom_reflection_1.typeRelationsCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "typeRelationsCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('reflectedTypeCapability', $tom_reflection_1.reflectedTypeCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "reflectedTypeCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('libraryCapability', $tom_reflection_1.libraryCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "libraryCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('declarationsCapability', $tom_reflection_1.declarationsCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "declarationsCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('uriCapability', $tom_reflection_1.uriCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "uriCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('libraryDependenciesCapability', $tom_reflection_1.libraryDependenciesCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "libraryDependenciesCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('invokingCapability', $tom_reflection_1.invokingCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "invokingCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('typingCapability', $tom_reflection_1.typingCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "typingCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('delegateCapability', $tom_reflection_1.delegateCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "delegateCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('subtypeQuantifyCapability', $tom_reflection_1.subtypeQuantifyCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "subtypeQuantifyCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('superclassQuantifyCapability', $tom_reflection_1.superclassQuantifyCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "superclassQuantifyCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('typeAnnotationQuantifyCapability', $tom_reflection_1.typeAnnotationQuantifyCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "typeAnnotationQuantifyCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('typeAnnotationDeepQuantifyCapability', $tom_reflection_1.typeAnnotationDeepQuantifyCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "typeAnnotationDeepQuantifyCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('correspondingSetterQuantifyCapability', $tom_reflection_1.correspondingSetterQuantifyCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "correspondingSetterQuantifyCapability": $e');
    }
    try {
      interpreter.registerGlobalVariable('admitSubtypeCapability', $tom_reflection_1.admitSubtypeCapability, importPath, sourceUri: 'package:tom_reflection/src/reflection/capability.dart');
    } catch (e) {
      errors.add('Failed to register variable "admitSubtypeCapability": $e');
    }
    interpreter.registerGlobalGetter('tomRemoteApis', () => $tom_core_kernel_3.tomRemoteApis, importPath, sourceUri: 'package:tom_core_kernel/src/tombase/http_connection/endpoints_apis.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (tom_core_kernel):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'limited': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'limited');
        final o = D4.getRequiredArg<Object?>(positional, 0, 'o', 'limited');
        final maxLength = D4.getRequiredArg<dynamic>(positional, 1, 'maxLength', 'limited');
        return $tom_basics_2.limited(o, maxLength);
      },
      'rsaEncrypt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'rsaEncrypt');
        final myPublic = D4.getRequiredArg<dynamic>(positional, 0, 'myPublic', 'rsaEncrypt');
        final dataToEncrypt = D4.getRequiredArg<Uint8List>(positional, 1, 'dataToEncrypt', 'rsaEncrypt');
        return $tom_crypto_3.rsaEncrypt(myPublic, dataToEncrypt);
      },
      'rsaDecrypt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'rsaDecrypt');
        final myPrivate = D4.getRequiredArg<dynamic>(positional, 0, 'myPrivate', 'rsaDecrypt');
        final cipherText = D4.getRequiredArg<Uint8List>(positional, 1, 'cipherText', 'rsaDecrypt');
        return $tom_crypto_3.rsaDecrypt(myPrivate, cipherText);
      },
      'rsaSign': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'rsaSign');
        final privateKey = D4.getRequiredArg<dynamic>(positional, 0, 'privateKey', 'rsaSign');
        final dataToSign = D4.getRequiredArg<Uint8List>(positional, 1, 'dataToSign', 'rsaSign');
        return $tom_crypto_3.rsaSign(privateKey, dataToSign);
      },
      'rsaVerify': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'rsaVerify');
        final publicKey = D4.getRequiredArg<dynamic>(positional, 0, 'publicKey', 'rsaVerify');
        final signedData = D4.getRequiredArg<Uint8List>(positional, 1, 'signedData', 'rsaVerify');
        final signature = D4.getRequiredArg<Uint8List>(positional, 2, 'signature', 'rsaVerify');
        return $tom_crypto_3.rsaVerify(publicKey, signedData, signature);
      },
      'getRsaKeyPair': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getRsaKeyPair');
        final secureRandom = D4.getRequiredArg<dynamic>(positional, 0, 'secureRandom', 'getRsaKeyPair');
        return $tom_crypto_4.getRsaKeyPair(secureRandom);
      },
      'initializeBeanContext': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_1.initializeBeanContext();
      },
      'mergeMapsOneSided': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mergeMapsOneSided');
        final base = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'base', 'mergeMapsOneSided');
        final override = D4.getRequiredArg<Map<String, dynamic>>(positional, 1, 'override', 'mergeMapsOneSided');
        return $tom_core_kernel_10.mergeMapsOneSided(base, override);
      },
      'traverseAndProcess': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'traverseAndProcess');
        final tree = D4.getRequiredArg<Map<String, Object>>(positional, 0, 'tree', 'traverseAndProcess');
        if (positional.length <= 1) {
          throw ArgumentError('traverseAndProcess: Missing required argument "test" at position 1');
        }
        final testRaw = positional[1];
        final test = (String p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; };
        if (positional.length <= 2) {
          throw ArgumentError('traverseAndProcess: Missing required argument "processor" at position 2');
        }
        final processorRaw = positional[2];
        final processor = (String p0) { return D4.callInterpreterCallback(visitor, processorRaw, [p0]) as String; };
        return $tom_core_kernel_10.traverseAndProcess(tree, test, processor);
      },
      'traverseAndCreate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'traverseAndCreate');
        final tree = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'tree', 'traverseAndCreate');
        if (positional.length <= 1) {
          throw ArgumentError('traverseAndCreate: Missing required argument "nameTest" at position 1');
        }
        final nameTestRaw = positional[1];
        final nameTest = (String p0) { return D4.callInterpreterCallback(visitor, nameTestRaw, [p0]) as bool; };
        if (positional.length <= 2) {
          throw ArgumentError('traverseAndCreate: Missing required argument "creator" at position 2');
        }
        final creatorRaw = positional[2];
        final creator = (String p0, String p1, Map<String, dynamic> p2) { D4.callInterpreterCallback(visitor, creatorRaw, [p0, p1, p2]); };
        return $tom_core_kernel_10.traverseAndCreate(tree, nameTest, creator);
      },
      'getPathFromTree': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'getPathFromTree');
        final baseTree = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'baseTree', 'getPathFromTree');
        final path = D4.getRequiredArg<String>(positional, 1, 'path', 'getPathFromTree');
        final name = D4.getRequiredArg<String>(positional, 2, 'name', 'getPathFromTree');
        return $tom_core_kernel_10.getPathFromTree(baseTree, path, name);
      },
      'getObjectFromTree': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'getObjectFromTree');
        final baseTree = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'baseTree', 'getObjectFromTree');
        final path = D4.getRequiredArg<String>(positional, 1, 'path', 'getObjectFromTree');
        return $tom_core_kernel_10.getObjectFromTree(baseTree, path);
      },
      'processTree': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'processTree');
        final tree = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'tree', 'processTree');
        if (positional.length <= 1) {
          throw ArgumentError('processTree: Missing required argument "provider" at position 1');
        }
        final providerRaw = positional[1];
        final provider = (String p0, String p1, String p2) { return D4.callInterpreterCallback(visitor, providerRaw, [p0, p1, p2]) as Map<String, dynamic>; };
        return $tom_core_kernel_10.processTree(tree, provider);
      },
      'makeCleanJsonMap': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'makeCleanJsonMap');
        final map = D4.getRequiredArg<Map>(positional, 0, 'map', 'makeCleanJsonMap');
        return $tom_core_kernel_10.makeCleanJsonMap(map);
      },
      'substituteEnvVars': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'substituteEnvVars');
        final tree = D4.getRequiredArg<Map<String, Object>>(positional, 0, 'tree', 'substituteEnvVars');
        final environment = D4.getRequiredArg<Map<String, String>>(positional, 1, 'environment', 'substituteEnvVars');
        return $tom_core_kernel_10.substituteEnvVars(tree, environment);
      },
      'prettyJson': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'prettyJson');
        final json = D4.getRequiredArg<String>(positional, 0, 'json', 'prettyJson');
        return $tom_core_kernel_11.prettyJson(json);
      },
      'prettyJsonLine': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'prettyJsonLine');
        final json = D4.getRequiredArg<String>(positional, 0, 'json', 'prettyJsonLine');
        return $tom_core_kernel_11.prettyJsonLine(json);
      },
      'getFromCurrentZone': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_14.getFromCurrentZone<dynamic>();
      },
      'getObjectFromCurrentZone': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getObjectFromCurrentZone');
        final t = D4.getRequiredArg<Type>(positional, 0, 't', 'getObjectFromCurrentZone');
        return $tom_core_kernel_14.getObjectFromCurrentZone(t);
      },
      'runChecked': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'runChecked');
        if (positional.isEmpty) {
          throw ArgumentError('runChecked: Missing required argument "body" at position 0');
        }
        final bodyRaw = positional[0];
        final body = () { return D4.callInterpreterCallback(visitor, bodyRaw, []) as Future<dynamic>; };
        if (positional.length <= 1) {
          throw ArgumentError('runChecked: Missing required argument "onError" at position 1');
        }
        final onErrorRaw = positional[1];
        final onError = (Object p0, StackTrace p1) { return D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]) as Object; };
        return $tom_core_kernel_14.runChecked<dynamic>(body, onError);
      },
      'runCheckedSync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'runCheckedSync');
        if (positional.isEmpty) {
          throw ArgumentError('runCheckedSync: Missing required argument "body" at position 0');
        }
        final bodyRaw = positional[0];
        final body = () { return D4.callInterpreterCallback(visitor, bodyRaw, []) as dynamic; };
        if (positional.length <= 1) {
          throw ArgumentError('runCheckedSync: Missing required argument "onError" at position 1');
        }
        final onErrorRaw = positional[1];
        final onError = (Object p0, StackTrace p1) { return D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]) as Object; };
        return $tom_core_kernel_14.runCheckedSync<dynamic>(body, onError);
      },
      'tomPrintStackTrace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'tomPrintStackTrace');
        final s = D4.getRequiredArg<Object?>(positional, 0, 's', 'tomPrintStackTrace');
        final message = D4.getOptionalNamedArg<String?>(named, 'message');
        final depth = D4.getNamedArgWithDefault<int>(named, 'depth', -1);
        return $tom_core_kernel_14.tomPrintStackTrace(s, message: message, depth: depth);
      },
      'tomGetStackTrace': (visitor, positional, named, typeArgs) {
        final s = positional.isNotEmpty ? positional[0] as Object? : null;
        final depth = D4.getOptionalArgWithDefault<int>(positional, 1, 'depth', -1);
        return $tom_core_kernel_14.tomGetStackTrace(s, depth);
      },
      'tomGetStackTraceAsList': (visitor, positional, named, typeArgs) {
        final s = positional.isNotEmpty ? positional[0] as Object? : null;
        final depth = D4.getOptionalArgWithDefault<int>(positional, 1, 'depth', -1);
        return $tom_core_kernel_14.tomGetStackTraceAsList(s, depth);
      },
      'tomGetStackTraceAsTuple': (visitor, positional, named, typeArgs) {
        final s = positional.isNotEmpty ? positional[0] as Object? : null;
        final depth = D4.getOptionalArgWithDefault<int>(positional, 1, 'depth', -1);
        final $result = $tom_core_kernel_14.tomGetStackTraceAsTuple(s, depth);
        return InterpretedRecord([$result.$1, $result.$2], {});
      },
      'convertMinutesToUtcOffset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'convertMinutesToUtcOffset');
        final totalMinutes = D4.getRequiredArg<int>(positional, 0, 'totalMinutes', 'convertMinutesToUtcOffset');
        return $tom_core_kernel_13.convertMinutesToUtcOffset(totalMinutes);
      },
      'tomProtect': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'tomProtect');
        final data = D4.getRequiredArg<dynamic>(positional, 0, 'data', 'tomProtect');
        final fallback = D4.getRequiredArg<dynamic>(positional, 1, 'fallback', 'tomProtect');
        final resourceKey = D4.getRequiredArg<String>(positional, 2, 'resourceKey', 'tomProtect');
        return $tom_core_kernel_22.tomProtect<dynamic>(data, fallback, resourceKey);
      },
      'tomProtected': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'tomProtected');
        final resourceKey = D4.getRequiredArg<String>(positional, 0, 'resourceKey', 'tomProtected');
        return $tom_core_kernel_22.tomProtected(resourceKey);
      },
      'reflectionNoSuchInvokableError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 5, 'reflectionNoSuchInvokableError');
        final receiver = D4.getRequiredArg<Object?>(positional, 0, 'receiver', 'reflectionNoSuchInvokableError');
        final memberName = D4.getRequiredArg<String>(positional, 1, 'memberName', 'reflectionNoSuchInvokableError');
        final positionalArguments = D4.getRequiredArg<List>(positional, 2, 'positionalArguments', 'reflectionNoSuchInvokableError');
        final namedArguments = D4.getRequiredArg<Map<Symbol, dynamic>?>(positional, 3, 'namedArguments', 'reflectionNoSuchInvokableError');
        final kind = D4.getRequiredArg<$tom_reflection_1.StringInvocationKind>(positional, 4, 'kind', 'reflectionNoSuchInvokableError');
        return $tom_reflection_1.reflectionNoSuchInvokableError(receiver, memberName, positionalArguments, namedArguments, kind);
      },
      'reflectionNoSuchMethodError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'reflectionNoSuchMethodError');
        final receiver = D4.getRequiredArg<Object?>(positional, 0, 'receiver', 'reflectionNoSuchMethodError');
        final memberName = D4.getRequiredArg<String>(positional, 1, 'memberName', 'reflectionNoSuchMethodError');
        final positionalArguments = D4.getRequiredArg<List>(positional, 2, 'positionalArguments', 'reflectionNoSuchMethodError');
        final namedArguments = D4.getRequiredArg<Map<Symbol, dynamic>?>(positional, 3, 'namedArguments', 'reflectionNoSuchMethodError');
        return $tom_reflection_1.reflectionNoSuchMethodError(receiver, memberName, positionalArguments, namedArguments);
      },
      'reflectionNoSuchGetterError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'reflectionNoSuchGetterError');
        final receiver = D4.getRequiredArg<Object?>(positional, 0, 'receiver', 'reflectionNoSuchGetterError');
        final memberName = D4.getRequiredArg<String>(positional, 1, 'memberName', 'reflectionNoSuchGetterError');
        final positionalArguments = D4.getRequiredArg<List>(positional, 2, 'positionalArguments', 'reflectionNoSuchGetterError');
        final namedArguments = D4.getRequiredArg<Map<Symbol, dynamic>?>(positional, 3, 'namedArguments', 'reflectionNoSuchGetterError');
        return $tom_reflection_1.reflectionNoSuchGetterError(receiver, memberName, positionalArguments, namedArguments);
      },
      'reflectionNoSuchSetterError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'reflectionNoSuchSetterError');
        final receiver = D4.getRequiredArg<Object?>(positional, 0, 'receiver', 'reflectionNoSuchSetterError');
        final memberName = D4.getRequiredArg<String>(positional, 1, 'memberName', 'reflectionNoSuchSetterError');
        final positionalArguments = D4.getRequiredArg<List>(positional, 2, 'positionalArguments', 'reflectionNoSuchSetterError');
        final namedArguments = D4.getRequiredArg<Map<Symbol, dynamic>?>(positional, 3, 'namedArguments', 'reflectionNoSuchSetterError');
        return $tom_reflection_1.reflectionNoSuchSetterError(receiver, memberName, positionalArguments, namedArguments);
      },
      'reflectionNoSuchConstructorError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'reflectionNoSuchConstructorError');
        final receiver = D4.getRequiredArg<Object?>(positional, 0, 'receiver', 'reflectionNoSuchConstructorError');
        final constructorName = D4.getRequiredArg<String>(positional, 1, 'constructorName', 'reflectionNoSuchConstructorError');
        final positionalArguments = D4.getRequiredArg<List>(positional, 2, 'positionalArguments', 'reflectionNoSuchConstructorError');
        final namedArguments = D4.getRequiredArg<Map<Symbol, dynamic>?>(positional, 3, 'namedArguments', 'reflectionNoSuchConstructorError');
        return $tom_reflection_1.reflectionNoSuchConstructorError(receiver, constructorName, positionalArguments, namedArguments);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'limited': 'package:tom_basics/src/logging/logging.dart',
      'rsaEncrypt': 'package:tom_crypto/src/rsa_encryption.dart',
      'rsaDecrypt': 'package:tom_crypto/src/rsa_encryption.dart',
      'rsaSign': 'package:tom_crypto/src/rsa_encryption.dart',
      'rsaVerify': 'package:tom_crypto/src/rsa_encryption.dart',
      'getRsaKeyPair': 'package:tom_crypto/src/rsa_tools.dart',
      'initializeBeanContext': 'package:tom_core_kernel/src/tombase/beanlocator/bean_locator.dart',
      'mergeMapsOneSided': 'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart',
      'traverseAndProcess': 'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart',
      'traverseAndCreate': 'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart',
      'getPathFromTree': 'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart',
      'getObjectFromTree': 'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart',
      'processTree': 'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart',
      'makeCleanJsonMap': 'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart',
      'substituteEnvVars': 'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart',
      'prettyJson': 'package:tom_core_kernel/src/tombase/json/pretty_json.dart',
      'prettyJsonLine': 'package:tom_core_kernel/src/tombase/json/pretty_json.dart',
      'getFromCurrentZone': 'package:tom_core_kernel/src/tombase/little_things/little_things.dart',
      'getObjectFromCurrentZone': 'package:tom_core_kernel/src/tombase/little_things/little_things.dart',
      'runChecked': 'package:tom_core_kernel/src/tombase/little_things/little_things.dart',
      'runCheckedSync': 'package:tom_core_kernel/src/tombase/little_things/little_things.dart',
      'tomPrintStackTrace': 'package:tom_core_kernel/src/tombase/little_things/little_things.dart',
      'tomGetStackTrace': 'package:tom_core_kernel/src/tombase/little_things/little_things.dart',
      'tomGetStackTraceAsList': 'package:tom_core_kernel/src/tombase/little_things/little_things.dart',
      'tomGetStackTraceAsTuple': 'package:tom_core_kernel/src/tombase/little_things/little_things.dart',
      'convertMinutesToUtcOffset': 'package:tom_core_kernel/src/tombase/little_things/formatting.dart',
      'tomProtect': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'tomProtected': 'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'reflectionNoSuchInvokableError': 'package:tom_reflection/src/reflection/capability.dart',
      'reflectionNoSuchMethodError': 'package:tom_reflection/src/reflection/capability.dart',
      'reflectionNoSuchGetterError': 'package:tom_reflection/src/reflection/capability.dart',
      'reflectionNoSuchSetterError': 'package:tom_reflection/src/reflection/capability.dart',
      'reflectionNoSuchConstructorError': 'package:tom_reflection/src/reflection/capability.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'limited': 'String limited(Object? o, dynamic maxLength)',
      'rsaEncrypt': 'Uint8List rsaEncrypt(RSAPublicKey myPublic, Uint8List dataToEncrypt)',
      'rsaDecrypt': 'Uint8List rsaDecrypt(RSAPrivateKey myPrivate, Uint8List cipherText)',
      'rsaSign': 'Uint8List rsaSign(RSAPrivateKey privateKey, Uint8List dataToSign)',
      'rsaVerify': 'bool rsaVerify(RSAPublicKey publicKey, Uint8List signedData, Uint8List signature)',
      'getRsaKeyPair': 'AsymmetricKeyPair<PublicKey, PrivateKey> getRsaKeyPair(SecureRandom secureRandom)',
      'initializeBeanContext': 'void initializeBeanContext()',
      'mergeMapsOneSided': 'void mergeMapsOneSided(Map<String, dynamic> base, Map<String, dynamic> override)',
      'traverseAndProcess': 'void traverseAndProcess(Map<String, Object> tree, bool Function(String) test, String Function(String) processor)',
      'traverseAndCreate': 'void traverseAndCreate(Map<String, dynamic> tree, bool Function(String) nameTest, void Function(String key, String value, Map<String, dynamic> location) creator)',
      'getPathFromTree': 'Map<String, dynamic> getPathFromTree(Map<String, dynamic> baseTree, String path, String name)',
      'getObjectFromTree': 'Object getObjectFromTree(Map<String, dynamic> baseTree, String path)',
      'processTree': 'void processTree(Map<String, dynamic> tree, Map<String, dynamic> Function(String keyName, String path, String profileName) provider)',
      'makeCleanJsonMap': 'Map<String, Object> makeCleanJsonMap(Map map)',
      'substituteEnvVars': 'void substituteEnvVars(Map<String, Object> tree, Map<String, String> environment)',
      'prettyJson': 'String prettyJson(String json)',
      'prettyJsonLine': 'String prettyJsonLine(String json)',
      'getFromCurrentZone': 'T? getFromCurrentZone()',
      'getObjectFromCurrentZone': 'Object? getObjectFromCurrentZone(Type t)',
      'runChecked': 'Future<T> runChecked(Future<T> Function() body, Object Function(Object error, StackTrace stacktrace) onError)',
      'runCheckedSync': 'T runCheckedSync(T Function() body, Object Function(Object error, StackTrace stacktrace) onError)',
      'tomPrintStackTrace': 'void tomPrintStackTrace(Object? s, {String? message, int depth = -1})',
      'tomGetStackTrace': 'String tomGetStackTrace([Object? s, int depth = -1])',
      'tomGetStackTraceAsList': 'List<String> tomGetStackTraceAsList([Object? s, int depth = -1])',
      'tomGetStackTraceAsTuple': '(String, List<String>) tomGetStackTraceAsTuple([Object? s, int depth = -1])',
      'convertMinutesToUtcOffset': 'String convertMinutesToUtcOffset(int totalMinutes)',
      'tomProtect': 'T tomProtect(T data, T fallback, String resourceKey)',
      'tomProtected': 'bool tomProtected(String resourceKey)',
      'reflectionNoSuchInvokableError': 'dynamic reflectionNoSuchInvokableError(Object? receiver, String memberName, List positionalArguments, Map<Symbol, dynamic>? namedArguments, StringInvocationKind kind)',
      'reflectionNoSuchMethodError': 'dynamic reflectionNoSuchMethodError(Object? receiver, String memberName, List positionalArguments, Map<Symbol, dynamic>? namedArguments)',
      'reflectionNoSuchGetterError': 'dynamic reflectionNoSuchGetterError(Object? receiver, String memberName, List positionalArguments, Map<Symbol, dynamic>? namedArguments)',
      'reflectionNoSuchSetterError': 'dynamic reflectionNoSuchSetterError(Object? receiver, String memberName, List positionalArguments, Map<Symbol, dynamic>? namedArguments)',
      'reflectionNoSuchConstructorError': 'dynamic reflectionNoSuchConstructorError(Object? receiver, String constructorName, List positionalArguments, Map<Symbol, dynamic>? namedArguments)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:tom_basics/src/exception_base.dart',
      'package:tom_basics/src/logging/logging.dart',
      'package:tom_basics/src/runtime/platform_environment_runtime.dart',
      'package:tom_basics/src/runtime/platform_neutral.dart',
      'package:tom_core_kernel/src/tombase/beanlocator/bean_locator.dart',
      'package:tom_core_kernel/src/tombase/context/execution_context.dart',
      'package:tom_core_kernel/src/tombase/http_connection/endpoints_apis.dart',
      'package:tom_core_kernel/src/tombase/http_connection/headers.dart',
      'package:tom_core_kernel/src/tombase/http_connection/httpmethods.dart',
      'package:tom_core_kernel/src/tombase/http_connection/mimetypes.dart',
      'package:tom_core_kernel/src/tombase/http_connection/remote_context.dart',
      'package:tom_core_kernel/src/tombase/http_connection/server_connection.dart',
      'package:tom_core_kernel/src/tombase/isolate_pooling/tom_worker.dart',
      'package:tom_core_kernel/src/tombase/json/map_merge_and_process.dart',
      'package:tom_core_kernel/src/tombase/json/pretty_json.dart',
      'package:tom_core_kernel/src/tombase/little_things/exception_base.dart',
      'package:tom_core_kernel/src/tombase/little_things/formatting.dart',
      'package:tom_core_kernel/src/tombase/little_things/little_things.dart',
      'package:tom_core_kernel/src/tombase/logging/logging_isolate.dart',
      'package:tom_core_kernel/src/tombase/logging/remote_logoutput.dart',
      'package:tom_core_kernel/src/tombase/logging/remote_logserver.dart',
      'package:tom_core_kernel/src/tombase/observable/tom_observable.dart',
      'package:tom_core_kernel/src/tombase/observable/tom_observable_objects.dart',
      'package:tom_core_kernel/src/tombase/reflection/reflection.dart',
      'package:tom_core_kernel/src/tombase/resources/tom_resource_provider.dart',
      'package:tom_core_kernel/src/tombase/security/access_controls.dart',
      'package:tom_core_kernel/src/tombase/security/authentication_authorization.dart',
      'package:tom_core_kernel/src/tombase/security/bearer_authentication.dart',
      'package:tom_core_kernel/src/tombase/security/user_principal_aci.dart',
      'package:tom_core_kernel/src/tombase/settings/settings_client_authorization.dart',
      'package:tom_core_kernel/src/tombase/shutdown_cleanup/tom_shutdown_cleanup.dart',
      'package:tom_core_kernel/src/tombase/timezoned/date_timestamp.dart',
      'package:tom_core_kernel/src/tombase/timezoned/timezones.dart',
      'package:tom_crypto/src/jwt_token.dart',
      'package:tom_crypto/src/password_hashing.dart',
      'package:tom_crypto/src/rsa_encryption.dart',
      'package:tom_crypto/src/rsa_tools.dart',
      'package:tom_reflection/src/reflection/capability.dart',
      'package:tom_reflection/src/reflection/mirrors.dart',
      'package:tom_reflection/src/reflection/reflection_builder_based.dart',
      'package:tom_reflection/tom_reflection.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    final imports = StringBuffer();
    imports.writeln("import 'package:tom_core_kernel/tom_core_kernel.dart';");
    imports.writeln("import 'package:tom_basics/tom_basics.dart';");
    imports.writeln("import 'package:tom_crypto/tom_crypto.dart';");
    imports.writeln("import 'package:tom_reflection/tom_reflection.dart';");
    return imports.toString();
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [
      'package:tom_basics/tom_basics.dart',
      'package:tom_crypto/tom_crypto.dart',
      'package:tom_reflection/tom_reflection.dart',
    ];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'StringInvocationKind',
  ];

}

// =============================================================================
// TomBaseException Bridge
// =============================================================================

BridgedClass _createTomBaseExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_basics_1.TomBaseException,
    name: 'TomBaseException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomBaseException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomBaseException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomBaseException');
        final requestUuid = D4.getOptionalNamedArg<String?>(named, 'requestUuid');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final uuid = D4.getOptionalNamedArg<String?>(named, 'uuid');
        return $tom_basics_1.TomBaseException(key, defaultUserMessage, requestUuid: requestUuid, parameters: parameters, rootException: rootException, stack: stack, uuid: uuid);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').stackTrace,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').stackTrace = value as String,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomBaseException(String key, String defaultUserMessage, {String? requestUuid, Map<String, Object?>? parameters, Object? rootException, Object? stack, String? uuid})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// TomLogLevel Bridge
// =============================================================================

BridgedClass _createTomLogLevelBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomLogLevel,
    name: 'TomLogLevel',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomLogLevel');
        final levelPattern = D4.getRequiredArg<int>(positional, 0, 'levelPattern', 'TomLogLevel');
        return $tom_basics_2.TomLogLevel(levelPattern);
      },
    },
    getters: {
      'levelPattern': (visitor, target) => D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel').levelPattern,
    },
    setters: {
      'levelPattern': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel').levelPattern = value as int,
    },
    methods: {
      'matches': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel');
        D4.requireMinArgs(positional, 1, 'matches');
        final messageLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'messageLevel', 'matches');
        return t.matches(messageLevel);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel');
        final other = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel');
        final other = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'other', 'operator-');
        return t - other;
      },
    },
    staticGetters: {
      'trace': (visitor) => $tom_basics_2.TomLogLevel.trace,
      'debug': (visitor) => $tom_basics_2.TomLogLevel.debug,
      'traffic': (visitor) => $tom_basics_2.TomLogLevel.traffic,
      'info': (visitor) => $tom_basics_2.TomLogLevel.info,
      'warn': (visitor) => $tom_basics_2.TomLogLevel.warn,
      'status': (visitor) => $tom_basics_2.TomLogLevel.status,
      'error': (visitor) => $tom_basics_2.TomLogLevel.error,
      'severe': (visitor) => $tom_basics_2.TomLogLevel.severe,
      'fatal': (visitor) => $tom_basics_2.TomLogLevel.fatal,
      'all': (visitor) => $tom_basics_2.TomLogLevel.all,
      'development': (visitor) => $tom_basics_2.TomLogLevel.development,
      'extended': (visitor) => $tom_basics_2.TomLogLevel.extended,
      'errors': (visitor) => $tom_basics_2.TomLogLevel.errors,
      'production': (visitor) => $tom_basics_2.TomLogLevel.production,
      'still': (visitor) => $tom_basics_2.TomLogLevel.still,
      'silent': (visitor) => $tom_basics_2.TomLogLevel.silent,
      'off': (visitor) => $tom_basics_2.TomLogLevel.off,
      'none': (visitor) => $tom_basics_2.TomLogLevel.none,
    },
    staticMethods: {
      'byName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'byName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'byName');
        return $tom_basics_2.TomLogLevel.byName(name);
      },
    },
    staticSetters: {
      'trace': (visitor, value) => 
        $tom_basics_2.TomLogLevel.trace = value as $tom_basics_2.TomLogLevel,
      'debug': (visitor, value) => 
        $tom_basics_2.TomLogLevel.debug = value as $tom_basics_2.TomLogLevel,
      'traffic': (visitor, value) => 
        $tom_basics_2.TomLogLevel.traffic = value as $tom_basics_2.TomLogLevel,
      'info': (visitor, value) => 
        $tom_basics_2.TomLogLevel.info = value as $tom_basics_2.TomLogLevel,
      'warn': (visitor, value) => 
        $tom_basics_2.TomLogLevel.warn = value as $tom_basics_2.TomLogLevel,
      'status': (visitor, value) => 
        $tom_basics_2.TomLogLevel.status = value as $tom_basics_2.TomLogLevel,
      'error': (visitor, value) => 
        $tom_basics_2.TomLogLevel.error = value as $tom_basics_2.TomLogLevel,
      'severe': (visitor, value) => 
        $tom_basics_2.TomLogLevel.severe = value as $tom_basics_2.TomLogLevel,
      'fatal': (visitor, value) => 
        $tom_basics_2.TomLogLevel.fatal = value as $tom_basics_2.TomLogLevel,
      'all': (visitor, value) => 
        $tom_basics_2.TomLogLevel.all = value as $tom_basics_2.TomLogLevel,
      'development': (visitor, value) => 
        $tom_basics_2.TomLogLevel.development = value as $tom_basics_2.TomLogLevel,
      'extended': (visitor, value) => 
        $tom_basics_2.TomLogLevel.extended = value as $tom_basics_2.TomLogLevel,
      'errors': (visitor, value) => 
        $tom_basics_2.TomLogLevel.errors = value as $tom_basics_2.TomLogLevel,
      'production': (visitor, value) => 
        $tom_basics_2.TomLogLevel.production = value as $tom_basics_2.TomLogLevel,
      'still': (visitor, value) => 
        $tom_basics_2.TomLogLevel.still = value as $tom_basics_2.TomLogLevel,
      'silent': (visitor, value) => 
        $tom_basics_2.TomLogLevel.silent = value as $tom_basics_2.TomLogLevel,
      'off': (visitor, value) => 
        $tom_basics_2.TomLogLevel.off = value as $tom_basics_2.TomLogLevel,
      'none': (visitor, value) => 
        $tom_basics_2.TomLogLevel.none = value as $tom_basics_2.TomLogLevel,
    },
    constructorSignatures: {
      '': 'TomLogLevel(int levelPattern)',
    },
    methodSignatures: {
      'matches': 'bool matches(TomLogLevel messageLevel)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'levelPattern': 'int get levelPattern',
    },
    setterSignatures: {
      'levelPattern': 'set levelPattern(dynamic value)',
    },
    staticMethodSignatures: {
      'byName': 'TomLogLevel? byName(String name)',
    },
    staticGetterSignatures: {
      'trace': 'TomLogLevel get trace',
      'debug': 'TomLogLevel get debug',
      'traffic': 'TomLogLevel get traffic',
      'info': 'TomLogLevel get info',
      'warn': 'TomLogLevel get warn',
      'status': 'TomLogLevel get status',
      'error': 'TomLogLevel get error',
      'severe': 'TomLogLevel get severe',
      'fatal': 'TomLogLevel get fatal',
      'all': 'TomLogLevel get all',
      'development': 'TomLogLevel get development',
      'extended': 'TomLogLevel get extended',
      'errors': 'TomLogLevel get errors',
      'production': 'TomLogLevel get production',
      'still': 'TomLogLevel get still',
      'silent': 'TomLogLevel get silent',
      'off': 'TomLogLevel get off',
      'none': 'TomLogLevel get none',
    },
    staticSetterSignatures: {
      'trace': 'set trace(dynamic value)',
      'debug': 'set debug(dynamic value)',
      'traffic': 'set traffic(dynamic value)',
      'info': 'set info(dynamic value)',
      'warn': 'set warn(dynamic value)',
      'status': 'set status(dynamic value)',
      'error': 'set error(dynamic value)',
      'severe': 'set severe(dynamic value)',
      'fatal': 'set fatal(dynamic value)',
      'all': 'set all(dynamic value)',
      'development': 'set development(dynamic value)',
      'extended': 'set extended(dynamic value)',
      'errors': 'set errors(dynamic value)',
      'production': 'set production(dynamic value)',
      'still': 'set still(dynamic value)',
      'silent': 'set silent(dynamic value)',
      'off': 'set off(dynamic value)',
      'none': 'set none(dynamic value)',
    },
  );
}

// =============================================================================
// TomLogger Bridge
// =============================================================================

BridgedClass _createTomLoggerBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomLogger,
    name: 'TomLogger',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_basics_2.TomLogger();
      },
    },
    getters: {
      'logLevel': (visitor, target) => D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger').logLevel,
      'logOutput': (visitor, target) => D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger').logOutput,
    },
    setters: {
      'logOutput': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger').logOutput = value as $tom_basics_2.TomLogOutput,
    },
    methods: {
      'setLogLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'setLogLevel');
        final l = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'l', 'setLogLevel');
        t.setLogLevel(l);
        return null;
      },
      'pushLogLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'pushLogLevel');
        final l = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'l', 'pushLogLevel');
        t.pushLogLevel(l);
        return null;
      },
      'popLogLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        t.popLogLevel();
        return null;
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'info');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'info');
        t.info(s);
        return null;
      },
      'warn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'warn');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'warn');
        t.warn(s);
        return null;
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'error');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'error');
        t.error(s);
        return null;
      },
      'debug': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'debug');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'debug');
        t.debug(s);
        return null;
      },
      'trace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'trace');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'trace');
        t.trace(s);
        return null;
      },
      'traffic': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'traffic');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'traffic');
        t.traffic(s);
        return null;
      },
      'severe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'severe');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'severe');
        t.severe(s);
        return null;
      },
      'fatal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'fatal');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'fatal');
        t.fatal(s);
        return null;
      },
      'status': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'status');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'status');
        t.status(s);
        return null;
      },
      'output': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 3, 'output');
        final messageLogLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'messageLogLevel', 'output');
        final level = D4.getRequiredArg<String>(positional, 1, 'level', 'output');
        final message = D4.getRequiredArg<Object>(positional, 2, 'message', 'output');
        t.output(messageLogLevel, level, message);
        return null;
      },
      'addNameLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 2, 'addNameLevel');
        final t_ = D4.getRequiredArg<String>(positional, 0, 't', 'addNameLevel');
        final tll = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'tll', 'addNameLevel');
        t.addNameLevel(t_, tll);
        return null;
      },
      'getNameLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'getNameLevel');
        final t_ = D4.getRequiredArg<String>(positional, 0, 't', 'getNameLevel');
        return t.getNameLevel(t_);
      },
      'removeNameLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'removeNameLevel');
        final t_ = D4.getRequiredArg<String>(positional, 0, 't', 'removeNameLevel');
        t.removeNameLevel(t_);
        return null;
      },
      'setLogLevelByName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'setLogLevelByName');
        final levelName = D4.getRequiredArg<String>(positional, 0, 'levelName', 'setLogLevelByName');
        t.setLogLevelByName(levelName);
        return null;
      },
      'setLogLevelExceptions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'setLogLevelExceptions');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'setLogLevelExceptions');
        t.setLogLevelExceptions(pattern);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        return t.toString();
      },
    },
    staticGetters: {
      'INFO': (visitor) => $tom_basics_2.TomLogger.INFO,
      'ERROR': (visitor) => $tom_basics_2.TomLogger.ERROR,
      'WARN': (visitor) => $tom_basics_2.TomLogger.WARN,
      'DEBUG': (visitor) => $tom_basics_2.TomLogger.DEBUG,
      'TRACE': (visitor) => $tom_basics_2.TomLogger.TRACE,
      'TRAFFIC': (visitor) => $tom_basics_2.TomLogger.TRAFFIC,
      'SEVERE': (visitor) => $tom_basics_2.TomLogger.SEVERE,
      'FATAL': (visitor) => $tom_basics_2.TomLogger.FATAL,
      'STATUS': (visitor) => $tom_basics_2.TomLogger.STATUS,
      'globalSettingDetermineCaller': (visitor) => $tom_basics_2.TomLogger.globalSettingDetermineCaller,
      'fallback': (visitor) => $tom_basics_2.TomLogger.fallback,
      'globalSettingInfoEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingInfoEnabled,
      'globalSettingWarnEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingWarnEnabled,
      'globalSettingErrorEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingErrorEnabled,
      'globalSettingDebugEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingDebugEnabled,
      'globalSettingTraceEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingTraceEnabled,
      'globalSettingTrafficEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingTrafficEnabled,
      'globalSettingSevereEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingSevereEnabled,
      'globalSettingFatalEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingFatalEnabled,
      'globalSettingStatusEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingStatusEnabled,
    },
    staticSetters: {
      'globalSettingDetermineCaller': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingDetermineCaller = value as bool,
      'globalSettingInfoEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingInfoEnabled = value as bool,
      'globalSettingWarnEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingWarnEnabled = value as bool,
      'globalSettingErrorEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingErrorEnabled = value as bool,
      'globalSettingDebugEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingDebugEnabled = value as bool,
      'globalSettingTraceEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingTraceEnabled = value as bool,
      'globalSettingTrafficEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingTrafficEnabled = value as bool,
      'globalSettingSevereEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingSevereEnabled = value as bool,
      'globalSettingFatalEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingFatalEnabled = value as bool,
      'globalSettingStatusEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingStatusEnabled = value as bool,
    },
    constructorSignatures: {
      '': 'TomLogger()',
    },
    methodSignatures: {
      'setLogLevel': 'void setLogLevel(TomLogLevel l)',
      'pushLogLevel': 'void pushLogLevel(TomLogLevel l)',
      'popLogLevel': 'void popLogLevel()',
      'info': 'void info(Object s)',
      'warn': 'void warn(Object s)',
      'error': 'void error(Object s)',
      'debug': 'void debug(Object s)',
      'trace': 'void trace(Object s)',
      'traffic': 'void traffic(Object s)',
      'severe': 'void severe(Object s)',
      'fatal': 'void fatal(Object s)',
      'status': 'void status(Object s)',
      'output': 'void output(TomLogLevel messageLogLevel, String level, Object message)',
      'addNameLevel': 'void addNameLevel(String t, TomLogLevel tll)',
      'getNameLevel': 'TomLogLevel? getNameLevel(String t)',
      'removeNameLevel': 'void removeNameLevel(String t)',
      'setLogLevelByName': 'void setLogLevelByName(String levelName)',
      'setLogLevelExceptions': 'void setLogLevelExceptions(String pattern)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'logLevel': 'TomLogLevel get logLevel',
      'logOutput': 'TomLogOutput get logOutput',
    },
    setterSignatures: {
      'logOutput': 'set logOutput(dynamic value)',
    },
    staticGetterSignatures: {
      'INFO': 'String get INFO',
      'ERROR': 'String get ERROR',
      'WARN': 'String get WARN',
      'DEBUG': 'String get DEBUG',
      'TRACE': 'String get TRACE',
      'TRAFFIC': 'String get TRAFFIC',
      'SEVERE': 'String get SEVERE',
      'FATAL': 'String get FATAL',
      'STATUS': 'String get STATUS',
      'globalSettingDetermineCaller': 'bool get globalSettingDetermineCaller',
      'fallback': 'Type get fallback',
      'globalSettingInfoEnabled': 'bool get globalSettingInfoEnabled',
      'globalSettingWarnEnabled': 'bool get globalSettingWarnEnabled',
      'globalSettingErrorEnabled': 'bool get globalSettingErrorEnabled',
      'globalSettingDebugEnabled': 'bool get globalSettingDebugEnabled',
      'globalSettingTraceEnabled': 'bool get globalSettingTraceEnabled',
      'globalSettingTrafficEnabled': 'bool get globalSettingTrafficEnabled',
      'globalSettingSevereEnabled': 'bool get globalSettingSevereEnabled',
      'globalSettingFatalEnabled': 'bool get globalSettingFatalEnabled',
      'globalSettingStatusEnabled': 'bool get globalSettingStatusEnabled',
    },
    staticSetterSignatures: {
      'globalSettingDetermineCaller': 'set globalSettingDetermineCaller(dynamic value)',
      'globalSettingInfoEnabled': 'set globalSettingInfoEnabled(dynamic value)',
      'globalSettingWarnEnabled': 'set globalSettingWarnEnabled(dynamic value)',
      'globalSettingErrorEnabled': 'set globalSettingErrorEnabled(dynamic value)',
      'globalSettingDebugEnabled': 'set globalSettingDebugEnabled(dynamic value)',
      'globalSettingTraceEnabled': 'set globalSettingTraceEnabled(dynamic value)',
      'globalSettingTrafficEnabled': 'set globalSettingTrafficEnabled(dynamic value)',
      'globalSettingSevereEnabled': 'set globalSettingSevereEnabled(dynamic value)',
      'globalSettingFatalEnabled': 'set globalSettingFatalEnabled(dynamic value)',
      'globalSettingStatusEnabled': 'set globalSettingStatusEnabled(dynamic value)',
    },
  );
}

// =============================================================================
// TomLoggable Bridge
// =============================================================================

BridgedClass _createTomLoggableBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomLoggable,
    name: 'TomLoggable',
    constructors: {
    },
    getters: {
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_basics_2.TomLoggable>(target, 'TomLoggable').logRepresentation,
    },
    getterSignatures: {
      'logRepresentation': 'String get logRepresentation',
    },
  );
}

// =============================================================================
// TomLogOutput Bridge
// =============================================================================

BridgedClass _createTomLogOutputBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomLogOutput,
    name: 'TomLogOutput',
    constructors: {
    },
    methods: {
      'output': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogOutput>(target, 'TomLogOutput');
        D4.requireMinArgs(positional, 7, 'output');
        final loggerLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'loggerLevel', 'output');
        final logLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'logLevel', 'output');
        final level = D4.getRequiredArg<String>(positional, 2, 'level', 'output');
        final message = D4.getRequiredArg<Object>(positional, 3, 'message', 'output');
        final isolateName = D4.getRequiredArg<String>(positional, 4, 'isolateName', 'output');
        final timeStamp = D4.getRequiredArg<DateTime>(positional, 5, 'timeStamp', 'output');
        final origin = D4.getRequiredArg<String?>(positional, 6, 'origin', 'output');
        t.output(loggerLevel, logLevel, level, message, isolateName, timeStamp, origin);
        return null;
      },
      'convertToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogOutput>(target, 'TomLogOutput');
        D4.requireMinArgs(positional, 1, 'convertToString');
        final message = D4.getRequiredArg<Object>(positional, 0, 'message', 'convertToString');
        return t.convertToString(message);
      },
    },
    staticGetters: {
      'globalSettingRemoteLogEndpoint': (visitor) => $tom_basics_2.TomLogOutput.globalSettingRemoteLogEndpoint,
    },
    staticSetters: {
      'globalSettingRemoteLogEndpoint': (visitor, value) => 
        $tom_basics_2.TomLogOutput.globalSettingRemoteLogEndpoint = value as String,
    },
    methodSignatures: {
      'output': 'void output(TomLogLevel loggerLevel, TomLogLevel logLevel, String level, Object message, String isolateName, DateTime timeStamp, String? origin)',
      'convertToString': 'String convertToString(Object message)',
    },
    staticGetterSignatures: {
      'globalSettingRemoteLogEndpoint': 'String get globalSettingRemoteLogEndpoint',
    },
    staticSetterSignatures: {
      'globalSettingRemoteLogEndpoint': 'set globalSettingRemoteLogEndpoint(dynamic value)',
    },
  );
}

// =============================================================================
// TomConsoleLogOutput Bridge
// =============================================================================

BridgedClass _createTomConsoleLogOutputBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomConsoleLogOutput,
    name: 'TomConsoleLogOutput',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_basics_2.TomConsoleLogOutput();
      },
    },
    getters: {
      'useExtendedFormat': (visitor, target) => D4.validateTarget<$tom_basics_2.TomConsoleLogOutput>(target, 'TomConsoleLogOutput').useExtendedFormat,
    },
    setters: {
      'useExtendedFormat': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_2.TomConsoleLogOutput>(target, 'TomConsoleLogOutput').useExtendedFormat = value as bool,
    },
    methods: {
      'output': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomConsoleLogOutput>(target, 'TomConsoleLogOutput');
        D4.requireMinArgs(positional, 6, 'output');
        final loggerLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'loggerLevel', 'output');
        final logLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'logLevel', 'output');
        final level = D4.getRequiredArg<String>(positional, 2, 'level', 'output');
        final message = D4.getRequiredArg<Object>(positional, 3, 'message', 'output');
        final isolateName = D4.getRequiredArg<String>(positional, 4, 'isolateName', 'output');
        final timeStamp = D4.getRequiredArg<DateTime>(positional, 5, 'timeStamp', 'output');
        final origin = D4.getOptionalArg<String?>(positional, 6, 'origin');
        t.output(loggerLevel, logLevel, level, message, isolateName, timeStamp, origin);
        return null;
      },
      'convertToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomConsoleLogOutput>(target, 'TomConsoleLogOutput');
        D4.requireMinArgs(positional, 1, 'convertToString');
        final message = D4.getRequiredArg<Object>(positional, 0, 'message', 'convertToString');
        return t.convertToString(message);
      },
    },
    staticGetters: {
      'globalSettingStderrLogLevel': (visitor) => $tom_basics_2.TomConsoleLogOutput.globalSettingStderrLogLevel,
      'globalSettingStdoutLogLevel': (visitor) => $tom_basics_2.TomConsoleLogOutput.globalSettingStdoutLogLevel,
    },
    staticSetters: {
      'globalSettingStderrLogLevel': (visitor, value) => 
        $tom_basics_2.TomConsoleLogOutput.globalSettingStderrLogLevel = value as $tom_basics_2.TomLogLevel,
      'globalSettingStdoutLogLevel': (visitor, value) => 
        $tom_basics_2.TomConsoleLogOutput.globalSettingStdoutLogLevel = value as $tom_basics_2.TomLogLevel,
    },
    constructorSignatures: {
      '': 'TomConsoleLogOutput()',
    },
    methodSignatures: {
      'output': 'void output(TomLogLevel loggerLevel, TomLogLevel logLevel, String level, Object message, String isolateName, DateTime timeStamp, [String? origin])',
      'convertToString': 'String convertToString(Object message)',
    },
    getterSignatures: {
      'useExtendedFormat': 'bool get useExtendedFormat',
    },
    setterSignatures: {
      'useExtendedFormat': 'set useExtendedFormat(dynamic value)',
    },
    staticGetterSignatures: {
      'globalSettingStderrLogLevel': 'TomLogLevel get globalSettingStderrLogLevel',
      'globalSettingStdoutLogLevel': 'TomLogLevel get globalSettingStdoutLogLevel',
    },
    staticSetterSignatures: {
      'globalSettingStderrLogLevel': 'set globalSettingStderrLogLevel(dynamic value)',
      'globalSettingStdoutLogLevel': 'set globalSettingStdoutLogLevel(dynamic value)',
    },
  );
}

// =============================================================================
// TomPlatformUtils Bridge
// =============================================================================

BridgedClass _createTomPlatformUtilsBridge() {
  return BridgedClass(
    nativeType: $tom_basics_4.TomPlatformUtils,
    name: 'TomPlatformUtils',
    constructors: {
    },
    methods: {
      'isDesktop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isDesktop();
      },
      'isMobile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isMobile();
      },
      'isWeb': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isWeb();
      },
      'isWindows': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isWindows();
      },
      'isLinux': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isLinux();
      },
      'isMacOs': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isMacOs();
      },
      'isFuchsia': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isFuchsia();
      },
      'isAndroid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isAndroid();
      },
      'isIos': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isIos();
      },
      'outError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        D4.requireMinArgs(positional, 1, 'outError');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'outError');
        t.outError(s);
        return null;
      },
      'out': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        D4.requireMinArgs(positional, 1, 'out');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'out');
        t.out(s);
        return null;
      },
      'httpClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.httpClient();
      },
      'getTomEnvVars': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.getTomEnvVars();
      },
      'getBrowserLocation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.getBrowserLocation();
      },
      'getIsolateName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.getIsolateName();
      },
    },
    staticGetters: {
      'envVars': (visitor) => $tom_basics_4.TomPlatformUtils.envVars,
      'current': (visitor) => $tom_basics_4.TomPlatformUtils.current,
    },
    staticMethods: {
      'setCurrentPlatform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setCurrentPlatform');
        final newCurrent = D4.getRequiredArg<$tom_basics_4.TomPlatformUtils>(positional, 0, 'newCurrent', 'setCurrentPlatform');
        return $tom_basics_4.TomPlatformUtils.setCurrentPlatform(newCurrent);
      },
    },
    staticSetters: {
      'envVars': (visitor, value) => 
        $tom_basics_4.TomPlatformUtils.envVars = (value as Map).cast<String, String>(),
    },
    methodSignatures: {
      'isDesktop': 'bool isDesktop()',
      'isMobile': 'bool isMobile()',
      'isWeb': 'bool isWeb()',
      'isWindows': 'bool isWindows()',
      'isLinux': 'bool isLinux()',
      'isMacOs': 'bool isMacOs()',
      'isFuchsia': 'bool isFuchsia()',
      'isAndroid': 'bool isAndroid()',
      'isIos': 'bool isIos()',
      'outError': 'void outError(String s)',
      'out': 'void out(String s)',
      'httpClient': 'Client httpClient()',
      'getTomEnvVars': 'Map<String, String> getTomEnvVars()',
      'getBrowserLocation': 'String? getBrowserLocation()',
      'getIsolateName': 'String getIsolateName()',
    },
    staticMethodSignatures: {
      'setCurrentPlatform': 'void setCurrentPlatform(TomPlatformUtils newCurrent)',
    },
    staticGetterSignatures: {
      'envVars': 'Map<String, String> get envVars',
      'current': 'TomPlatformUtils get current',
    },
    staticSetterSignatures: {
      'envVars': 'set envVars(dynamic value)',
    },
  );
}

// =============================================================================
// TomFallbackPlatformUtils Bridge
// =============================================================================

BridgedClass _createTomFallbackPlatformUtilsBridge() {
  return BridgedClass(
    nativeType: $tom_basics_4.TomFallbackPlatformUtils,
    name: 'TomFallbackPlatformUtils',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_basics_4.TomFallbackPlatformUtils();
      },
    },
    methods: {
      'isDesktop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isDesktop();
      },
      'isMobile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isMobile();
      },
      'isWeb': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isWeb();
      },
      'isWindows': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isWindows();
      },
      'isLinux': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isLinux();
      },
      'isMacOs': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isMacOs();
      },
      'isFuchsia': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isFuchsia();
      },
      'isAndroid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isAndroid();
      },
      'isIos': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isIos();
      },
      'outError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        D4.requireMinArgs(positional, 1, 'outError');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'outError');
        t.outError(s);
        return null;
      },
      'out': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        D4.requireMinArgs(positional, 1, 'out');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'out');
        t.out(s);
        return null;
      },
      'httpClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.httpClient();
      },
      'getTomEnvVars': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.getTomEnvVars();
      },
      'getBrowserLocation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.getBrowserLocation();
      },
      'getIsolateName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.getIsolateName();
      },
    },
    constructorSignatures: {
      '': 'TomFallbackPlatformUtils()',
    },
    methodSignatures: {
      'isDesktop': 'bool isDesktop()',
      'isMobile': 'bool isMobile()',
      'isWeb': 'bool isWeb()',
      'isWindows': 'bool isWindows()',
      'isLinux': 'bool isLinux()',
      'isMacOs': 'bool isMacOs()',
      'isFuchsia': 'bool isFuchsia()',
      'isAndroid': 'bool isAndroid()',
      'isIos': 'bool isIos()',
      'outError': 'void outError(String s)',
      'out': 'void out(String s)',
      'httpClient': 'Client httpClient()',
      'getTomEnvVars': 'Map<String, String> getTomEnvVars()',
      'getBrowserLocation': 'String? getBrowserLocation()',
      'getIsolateName': 'String getIsolateName()',
    },
  );
}

// =============================================================================
// TomEnvironment Bridge
// =============================================================================

BridgedClass _createTomEnvironmentBridge() {
  return BridgedClass(
    nativeType: $tom_basics_3.TomEnvironment,
    name: 'TomEnvironment',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomEnvironment');
        final env = D4.getRequiredArg<String>(positional, 0, 'env', 'TomEnvironment');
        final parent = D4.getOptionalNamedArg<$tom_basics_3.TomEnvironment?>(named, 'parent');
        final initializerRaw = named['initializer'];
        final isTest = D4.getNamedArgWithDefault<bool>(named, 'isTest', false);
        final isDevelopment = D4.getNamedArgWithDefault<bool>(named, 'isDevelopment', false);
        return $tom_basics_3.TomEnvironment(env, parent: parent, initializer: initializerRaw == null ? null : ($tom_basics_3.TomEnvironment p0) { D4.callInterpreterCallback(visitor, initializerRaw, [p0]); }, isTest: isTest, isDevelopment: isDevelopment);
      },
    },
    getters: {
      'parent': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').parent,
      'env': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').env,
      'initializer': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').initializer,
      'isTest': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').isTest,
      'isDevelopment': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').isDevelopment,
    },
    methods: {
      'initialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment');
        t.initialize();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TomEnvironment(String env, {TomEnvironment? parent, void Function(TomEnvironment)? initializer, bool isTest = false, bool isDevelopment = false})',
    },
    methodSignatures: {
      'initialize': 'void initialize()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'parent': 'TomEnvironment? get parent',
      'env': 'String get env',
      'initializer': 'void Function(TomEnvironment)? get initializer',
      'isTest': 'bool get isTest',
      'isDevelopment': 'bool get isDevelopment',
    },
  );
}

// =============================================================================
// TomPlatform Bridge
// =============================================================================

BridgedClass _createTomPlatformBridge() {
  return BridgedClass(
    nativeType: $tom_basics_3.TomPlatform,
    name: 'TomPlatform',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomPlatform');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TomPlatform');
        return $tom_basics_3.TomPlatform(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_basics_3.TomPlatform>(target, 'TomPlatform').name,
    },
    methods: {
      'setInitializer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomPlatform>(target, 'TomPlatform');
        D4.requireMinArgs(positional, 1, 'setInitializer');
        if (positional.isEmpty) {
          throw ArgumentError('setInitializer: Missing required argument "initializer" at position 0');
        }
        final initializerRaw = positional[0];
        t.setInitializer(($tom_basics_3.TomPlatform p0, $tom_basics_3.TomEnvironment? p1) { D4.callInterpreterCallback(visitor, initializerRaw, [p0, p1]); });
        return null;
      },
      'initializePlatform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomPlatform>(target, 'TomPlatform');
        D4.requireMinArgs(positional, 1, 'initializePlatform');
        final env = D4.getRequiredArg<$tom_basics_3.TomEnvironment?>(positional, 0, 'env', 'initializePlatform');
        t.initializePlatform(env);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomPlatform>(target, 'TomPlatform');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TomPlatform(String name)',
    },
    methodSignatures: {
      'setInitializer': 'void setInitializer(void Function(TomPlatform, TomEnvironment?) initializer)',
      'initializePlatform': 'void initializePlatform(TomEnvironment? env)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// TomRuntime Bridge
// =============================================================================

BridgedClass _createTomRuntimeBridge() {
  return BridgedClass(
    nativeType: $tom_basics_3.TomRuntime,
    name: 'TomRuntime',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_basics_3.TomRuntime();
      },
    },
    staticMethods: {
      'printReport': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.printReport();
      },
      'getEnvironments': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getEnvironments();
      },
      'addEnvironment': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addEnvironment');
        final env = D4.getRequiredArg<$tom_basics_3.TomEnvironment>(positional, 0, 'env', 'addEnvironment');
        return $tom_basics_3.TomRuntime.addEnvironment(env);
      },
      'setRootEnvironment': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setRootEnvironment');
        final env = D4.getRequiredArg<$tom_basics_3.TomEnvironment>(positional, 0, 'env', 'setRootEnvironment');
        return $tom_basics_3.TomRuntime.setRootEnvironment(env);
      },
      'setCurrentEnvironment': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setCurrentEnvironment');
        final name = D4.getRequiredArg<String?>(positional, 0, 'name', 'setCurrentEnvironment');
        final fallback = D4.getOptionalArgWithDefault<String>(positional, 1, 'fallback', "defaultRoot");
        return $tom_basics_3.TomRuntime.setCurrentEnvironment(name, fallback);
      },
      'getCurrentEnvironment': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getCurrentEnvironment();
      },
      'getEnvironmentHierarchy': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getEnvironmentHierarchy();
      },
      'getRoot': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getRoot();
      },
      'addPlatform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addPlatform');
        final platform = D4.getRequiredArg<$tom_basics_3.TomPlatform>(positional, 0, 'platform', 'addPlatform');
        return $tom_basics_3.TomRuntime.addPlatform(platform);
      },
      'getPlatforms': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getPlatforms();
      },
      'getCurrentPlatform': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getCurrentPlatform();
      },
      'setCurrentPlatform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setCurrentPlatform');
        final platform = D4.getRequiredArg<$tom_basics_3.TomPlatform>(positional, 0, 'platform', 'setCurrentPlatform');
        return $tom_basics_3.TomRuntime.setCurrentPlatform(platform);
      },
      'initializePlatform': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.initializePlatform();
      },
    },
    constructorSignatures: {
      '': 'TomRuntime()',
    },
    staticMethodSignatures: {
      'printReport': 'String printReport()',
      'getEnvironments': 'List<TomEnvironment> getEnvironments()',
      'addEnvironment': 'TomEnvironment addEnvironment(TomEnvironment env)',
      'setRootEnvironment': 'void setRootEnvironment(TomEnvironment env)',
      'setCurrentEnvironment': 'void setCurrentEnvironment(String? name, [String fallback = "defaultRoot"])',
      'getCurrentEnvironment': 'TomEnvironment getCurrentEnvironment()',
      'getEnvironmentHierarchy': 'List<TomEnvironment> getEnvironmentHierarchy()',
      'getRoot': 'TomEnvironment getRoot()',
      'addPlatform': 'TomPlatform addPlatform(TomPlatform platform)',
      'getPlatforms': 'List<TomPlatform> getPlatforms()',
      'getCurrentPlatform': 'TomPlatform? getCurrentPlatform()',
      'setCurrentPlatform': 'void setCurrentPlatform(TomPlatform platform)',
      'initializePlatform': 'void initializePlatform()',
    },
  );
}

// =============================================================================
// TomJwtTokenException Bridge
// =============================================================================

BridgedClass _createTomJwtTokenExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_crypto_1.TomJwtTokenException,
    name: 'TomJwtTokenException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomJwtTokenException');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'TomJwtTokenException');
        final defaultUserMessage = D4.getRequiredArg<dynamic>(positional, 1, 'defaultUserMessage', 'TomJwtTokenException');
        final parameters = D4.getOptionalNamedArg<dynamic>(named, 'parameters');
        final stack = D4.getOptionalNamedArg<dynamic>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<dynamic>(named, 'rootException');
        final uuid = D4.getOptionalNamedArg<dynamic>(named, 'uuid');
        return $tom_crypto_1.TomJwtTokenException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, uuid: uuid);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').stackTrace,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException').stackTrace = value as String,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_crypto_1.TomJwtTokenException>(target, 'TomJwtTokenException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomJwtTokenException(dynamic key, dynamic defaultUserMessage, {dynamic parameters, dynamic stack, dynamic rootException, dynamic uuid})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// TomJwtConfiguration Bridge
// =============================================================================

BridgedClass _createTomJwtConfigurationBridge() {
  return BridgedClass(
    nativeType: $tom_crypto_1.TomJwtConfiguration,
    name: 'TomJwtConfiguration',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'TomJwtConfiguration');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'TomJwtConfiguration');
        final algorithm = D4.getRequiredArg<dynamic>(positional, 1, 'algorithm', 'TomJwtConfiguration');
        final rsaPrivateKey = D4.getRequiredArg<dynamic>(positional, 2, 'rsaPrivateKey', 'TomJwtConfiguration');
        final rsaPublicKey = D4.getRequiredArg<dynamic>(positional, 3, 'rsaPublicKey', 'TomJwtConfiguration');
        final isDummy = D4.getOptionalArgWithDefault<bool>(positional, 4, 'isDummy', true);
        return $tom_crypto_1.TomJwtConfiguration(key, algorithm, rsaPrivateKey, rsaPublicKey, isDummy);
      },
    },
    getters: {
      'rsaPrivateKey': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').rsaPrivateKey,
      'rsaPublicKey': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').rsaPublicKey,
      'isDummy': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').isDummy,
      'key': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').key,
      'algorithm': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').algorithm,
    },
    setters: {
      'rsaPrivateKey': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').rsaPrivateKey = value as dynamic,
      'rsaPublicKey': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').rsaPublicKey = value as dynamic,
      'isDummy': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').isDummy = value as bool,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').key = value as dynamic,
      'algorithm': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration').algorithm = value as dynamic,
    },
    methods: {
      'encrypt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration');
        D4.requireMinArgs(positional, 1, 'encrypt');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'encrypt');
        return t.encrypt(s);
      },
      'decrypt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_crypto_1.TomJwtConfiguration>(target, 'TomJwtConfiguration');
        D4.requireMinArgs(positional, 1, 'decrypt');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'decrypt');
        return t.decrypt(s);
      },
    },
    staticGetters: {
      'hmacKey': (visitor) => $tom_crypto_1.TomJwtConfiguration.hmacKey,
      'rsaPrivKey': (visitor) => $tom_crypto_1.TomJwtConfiguration.rsaPrivKey,
      'rsaPubKey': (visitor) => $tom_crypto_1.TomJwtConfiguration.rsaPubKey,
      'defaultSignConfiguration': (visitor) => $tom_crypto_1.TomJwtConfiguration.defaultSignConfiguration,
    },
    staticSetters: {
      'defaultSignConfiguration': (visitor, value) => 
        $tom_crypto_1.TomJwtConfiguration.defaultSignConfiguration = value as $tom_crypto_1.TomJwtConfiguration,
    },
    constructorSignatures: {
      '': 'TomJwtConfiguration(dynamic key, dynamic algorithm, dynamic rsaPrivateKey, dynamic rsaPublicKey, [bool isDummy = true])',
    },
    methodSignatures: {
      'encrypt': 'String encrypt(String s)',
      'decrypt': 'String decrypt(String s)',
    },
    getterSignatures: {
      'rsaPrivateKey': 'RSAPrivateKey get rsaPrivateKey',
      'rsaPublicKey': 'RSAPublicKey get rsaPublicKey',
      'isDummy': 'bool get isDummy',
      'key': 'jwt.JWTKey get key',
      'algorithm': 'jwt.JWTAlgorithm get algorithm',
    },
    setterSignatures: {
      'rsaPrivateKey': 'set rsaPrivateKey(dynamic value)',
      'rsaPublicKey': 'set rsaPublicKey(dynamic value)',
      'isDummy': 'set isDummy(dynamic value)',
      'key': 'set key(dynamic value)',
      'algorithm': 'set algorithm(dynamic value)',
    },
    staticGetterSignatures: {
      'hmacKey': 'dynamic get hmacKey',
      'rsaPrivKey': 'dynamic get rsaPrivKey',
      'rsaPubKey': 'dynamic get rsaPubKey',
      'defaultSignConfiguration': 'TomJwtConfiguration get defaultSignConfiguration',
    },
    staticSetterSignatures: {
      'defaultSignConfiguration': 'set defaultSignConfiguration(dynamic value)',
    },
  );
}

// =============================================================================
// TomServerJwtToken Bridge
// =============================================================================

BridgedClass _createTomServerJwtTokenBridge() {
  return BridgedClass(
    nativeType: $tom_crypto_1.TomServerJwtToken,
    name: 'TomServerJwtToken',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomServerJwtToken');
        if (positional.isEmpty) {
          throw ArgumentError('TomServerJwtToken: Missing required argument "publicData" at position 0');
        }
        final publicData = D4.coerceMap<String, Object?>(positional[0], 'publicData');
        final encryptedData = named.containsKey('encryptedData') && named['encryptedData'] != null
            ? D4.coerceMap<String, Object?>(named['encryptedData'], 'encryptedData')
            : const <String, Object?>{};
        final expiresIn = D4.getNamedArgWithDefault<Duration>(named, 'expiresIn', const Duration(hours: 2));
        final notBefore = D4.getNamedArgWithDefault<Duration>(named, 'notBefore', const Duration(seconds: 0));
        final noIssueAt = D4.getNamedArgWithDefault<bool>(named, 'noIssueAt', false);
        final signingConfiguration = D4.getOptionalNamedArg<$tom_crypto_1.TomJwtConfiguration?>(named, 'signingConfiguration');
        return $tom_crypto_1.TomServerJwtToken(publicData, encryptedData: encryptedData, expiresIn: expiresIn, notBefore: notBefore, noIssueAt: noIssueAt, signingConfiguration: signingConfiguration);
      },
    },
    getters: {
      'signingConfiguration': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').signingConfiguration,
      'publicData': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').publicData,
      'encryptedData': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').encryptedData,
      'expiresIn': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').expiresIn,
      'notBefore': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').notBefore,
      'noIssueAt': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').noIssueAt,
    },
    setters: {
      'signingConfiguration': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').signingConfiguration = value as $tom_crypto_1.TomJwtConfiguration,
      'publicData': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').publicData = (value as Map).cast<String, Object?>(),
      'encryptedData': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').encryptedData = (value as Map).cast<String, Object?>(),
      'expiresIn': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').expiresIn = value as Duration,
      'notBefore': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').notBefore = value as Duration,
      'noIssueAt': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken').noIssueAt = value as bool,
    },
    methods: {
      'getJWT': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_crypto_1.TomServerJwtToken>(target, 'TomServerJwtToken');
        D4.requireMinArgs(positional, 1, 'getJWT');
        final issuer = D4.getRequiredArg<String>(positional, 0, 'issuer', 'getJWT');
        return t.getJWT(issuer);
      },
    },
    constructorSignatures: {
      '': 'TomServerJwtToken(Map<String, Object?> publicData, {Map<String, Object?> encryptedData = const {}, Duration expiresIn = const Duration(hours: 2), Duration notBefore = const Duration(seconds: 0), bool noIssueAt = false, TomJwtConfiguration? signingConfiguration})',
    },
    methodSignatures: {
      'getJWT': 'String getJWT(String issuer)',
    },
    getterSignatures: {
      'signingConfiguration': 'TomJwtConfiguration get signingConfiguration',
      'publicData': 'Map<String, Object?> get publicData',
      'encryptedData': 'Map<String, Object?> get encryptedData',
      'expiresIn': 'Duration get expiresIn',
      'notBefore': 'Duration get notBefore',
      'noIssueAt': 'bool get noIssueAt',
    },
    setterSignatures: {
      'signingConfiguration': 'set signingConfiguration(dynamic value)',
      'publicData': 'set publicData(dynamic value)',
      'encryptedData': 'set encryptedData(dynamic value)',
      'expiresIn': 'set expiresIn(dynamic value)',
      'notBefore': 'set notBefore(dynamic value)',
      'noIssueAt': 'set noIssueAt(dynamic value)',
    },
  );
}

// =============================================================================
// TomClientJwtToken Bridge
// =============================================================================

BridgedClass _createTomClientJwtTokenBridge() {
  return BridgedClass(
    nativeType: $tom_crypto_1.TomClientJwtToken,
    name: 'TomClientJwtToken',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomClientJwtToken');
        final token = D4.getRequiredArg<String>(positional, 0, 'token', 'TomClientJwtToken');
        final signingConfiguration = D4.getOptionalNamedArg<$tom_crypto_1.TomJwtConfiguration?>(named, 'signingConfiguration');
        final decrypt = D4.getNamedArgWithDefault<bool>(named, 'decrypt', true);
        return $tom_crypto_1.TomClientJwtToken(token, signingConfiguration: signingConfiguration, decrypt: decrypt);
      },
    },
    getters: {
      'decrypt': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').decrypt,
      'signingConfiguration': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').signingConfiguration,
      'token': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').token,
      'tokenString': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').tokenString,
      'secretData': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').secretData,
      'issuer': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').issuer,
      'subject': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').subject,
      'jwtId': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').jwtId,
      'audience': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').audience,
      'payload': (visitor, target) => D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').payload,
    },
    setters: {
      'signingConfiguration': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').signingConfiguration = value as $tom_crypto_1.TomJwtConfiguration,
      'token': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').token = value as dynamic,
      'tokenString': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').tokenString = value as String,
      'secretData': (visitor, target, value) => 
        D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken').secretData = value == null ? null : (value as Map).cast<String, dynamic>(),
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_crypto_1.TomClientJwtToken>(target, 'TomClientJwtToken');
        return t.toString();
      },
    },
    staticGetters: {
      'globalSettingShowContentInToString': (visitor) => $tom_crypto_1.TomClientJwtToken.globalSettingShowContentInToString,
    },
    staticSetters: {
      'globalSettingShowContentInToString': (visitor, value) => 
        $tom_crypto_1.TomClientJwtToken.globalSettingShowContentInToString = value as bool,
    },
    constructorSignatures: {
      '': 'TomClientJwtToken(String token, {TomJwtConfiguration? signingConfiguration, bool decrypt = true})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'decrypt': 'bool get decrypt',
      'signingConfiguration': 'TomJwtConfiguration get signingConfiguration',
      'token': 'jwt.JWT get token',
      'tokenString': 'String get tokenString',
      'secretData': 'Map<String, dynamic>? get secretData',
      'issuer': 'String? get issuer',
      'subject': 'String? get subject',
      'jwtId': 'String? get jwtId',
      'audience': 'jwt.Audience? get audience',
      'payload': 'Map<String, dynamic>? get payload',
    },
    setterSignatures: {
      'signingConfiguration': 'set signingConfiguration(dynamic value)',
      'token': 'set token(dynamic value)',
      'tokenString': 'set tokenString(dynamic value)',
      'secretData': 'set secretData(dynamic value)',
    },
    staticGetterSignatures: {
      'globalSettingShowContentInToString': 'bool get globalSettingShowContentInToString',
    },
    staticSetterSignatures: {
      'globalSettingShowContentInToString': 'set globalSettingShowContentInToString(dynamic value)',
    },
  );
}

// =============================================================================
// TomPasswordHasher Bridge
// =============================================================================

BridgedClass _createTomPasswordHasherBridge() {
  return BridgedClass(
    nativeType: $tom_crypto_2.TomPasswordHasher,
    name: 'TomPasswordHasher',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_crypto_2.TomPasswordHasher();
      },
    },
    staticGetters: {
      'globalSettingDefaultSaltLength': (visitor) => $tom_crypto_2.TomPasswordHasher.globalSettingDefaultSaltLength,
      'globalSettingDefaultHashSpec': (visitor) => $tom_crypto_2.TomPasswordHasher.globalSettingDefaultHashSpec,
    },
    staticMethods: {
      'verifyPassword': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'verifyPassword');
        final password = D4.getRequiredArg<String>(positional, 0, 'password', 'verifyPassword');
        final dbHash = D4.getRequiredArg<String>(positional, 1, 'dbHash', 'verifyPassword');
        final dbHashSpec = D4.getRequiredArg<String>(positional, 2, 'dbHashSpec', 'verifyPassword');
        return $tom_crypto_2.TomPasswordHasher.verifyPassword(password, dbHash, dbHashSpec);
      },
      'hashPassword': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'hashPassword');
        final password = D4.getRequiredArg<String>(positional, 0, 'password', 'hashPassword');
        return $tom_crypto_2.TomPasswordHasher.hashPassword(password);
      },
      'generateSalt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'generateSalt');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'generateSalt');
        return $tom_crypto_2.TomPasswordHasher.generateSalt(length);
      },
      'buildKeyDerivator': (visitor, positional, named, typeArgs) {
        final specs = D4.getOptionalArg<String?>(positional, 0, 'specs');
        final salt = D4.getOptionalArg<String?>(positional, 1, 'salt');
        return $tom_crypto_2.TomPasswordHasher.buildKeyDerivator(specs, salt);
      },
      'makeArgon2Params': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'makeArgon2Params');
        final specification = D4.getRequiredArg<String>(positional, 0, 'specification', 'makeArgon2Params');
        final saltHexString = D4.getRequiredArg<String>(positional, 1, 'saltHexString', 'makeArgon2Params');
        return $tom_crypto_2.TomPasswordHasher.makeArgon2Params(specification, saltHexString);
      },
      'parameterString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parameterString');
        final params = D4.getRequiredArg<dynamic>(positional, 0, 'params', 'parameterString');
        return $tom_crypto_2.TomPasswordHasher.parameterString(params);
      },
      'toHexString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'toHexString');
        final list = D4.getRequiredArg<Uint8List>(positional, 0, 'list', 'toHexString');
        return $tom_crypto_2.TomPasswordHasher.toHexString(list);
      },
      'toUint8List': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'toUint8List');
        final hexString = D4.getRequiredArg<String>(positional, 0, 'hexString', 'toUint8List');
        return $tom_crypto_2.TomPasswordHasher.toUint8List(hexString);
      },
    },
    staticSetters: {
      'globalSettingDefaultSaltLength': (visitor, value) => 
        $tom_crypto_2.TomPasswordHasher.globalSettingDefaultSaltLength = value as int,
      'globalSettingDefaultHashSpec': (visitor, value) => 
        $tom_crypto_2.TomPasswordHasher.globalSettingDefaultHashSpec = value as String,
    },
    constructorSignatures: {
      '': 'TomPasswordHasher()',
    },
    staticMethodSignatures: {
      'verifyPassword': 'bool verifyPassword(String password, String dbHash, String dbHashSpec)',
      'hashPassword': '(String, String) hashPassword(String password)',
      'generateSalt': 'String generateSalt(int length)',
      'buildKeyDerivator': 'KeyDerivator buildKeyDerivator([String? specs, String? salt])',
      'makeArgon2Params': 'Argon2Parameters makeArgon2Params(String specification, String saltHexString)',
      'parameterString': '(String, String) parameterString(Argon2Parameters params)',
      'toHexString': 'String toHexString(Uint8List list)',
      'toUint8List': 'Uint8List toUint8List(String hexString)',
    },
    staticGetterSignatures: {
      'globalSettingDefaultSaltLength': 'int get globalSettingDefaultSaltLength',
      'globalSettingDefaultHashSpec': 'String get globalSettingDefaultHashSpec',
    },
    staticSetterSignatures: {
      'globalSettingDefaultSaltLength': 'set globalSettingDefaultSaltLength(dynamic value)',
      'globalSettingDefaultHashSpec': 'set globalSettingDefaultHashSpec(dynamic value)',
    },
  );
}

// =============================================================================
// RsaKeyHelper Bridge
// =============================================================================

BridgedClass _createRsaKeyHelperBridge() {
  return BridgedClass(
    nativeType: $tom_crypto_4.RsaKeyHelper,
    name: 'RsaKeyHelper',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_crypto_4.RsaKeyHelper();
      },
    },
    staticMethods: {
      'computeRSAKeyPair': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'computeRSAKeyPair');
        final secureRandom = D4.getRequiredArg<dynamic>(positional, 0, 'secureRandom', 'computeRSAKeyPair');
        return $tom_crypto_4.RsaKeyHelper.computeRSAKeyPair(secureRandom);
      },
      'getSecureRandom': (visitor, positional, named, typeArgs) {
        return $tom_crypto_4.RsaKeyHelper.getSecureRandom();
      },
      'parsePublicKeyFromPem': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parsePublicKeyFromPem');
        final pemString = D4.getRequiredArg<String>(positional, 0, 'pemString', 'parsePublicKeyFromPem');
        return $tom_crypto_4.RsaKeyHelper.parsePublicKeyFromPem(pemString);
      },
      'sign': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'sign');
        final plainText = D4.getRequiredArg<String>(positional, 0, 'plainText', 'sign');
        final privateKey = D4.getRequiredArg<dynamic>(positional, 1, 'privateKey', 'sign');
        return $tom_crypto_4.RsaKeyHelper.sign(plainText, privateKey);
      },
      'rsaEncrypt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'rsaEncrypt');
        final myPublic = D4.getRequiredArg<dynamic>(positional, 0, 'myPublic', 'rsaEncrypt');
        final dataToEncrypt = D4.getRequiredArg<Uint8List>(positional, 1, 'dataToEncrypt', 'rsaEncrypt');
        return $tom_crypto_4.RsaKeyHelper.rsaEncrypt(myPublic, dataToEncrypt);
      },
      'rsaDecrypt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'rsaDecrypt');
        final myPrivate = D4.getRequiredArg<dynamic>(positional, 0, 'myPrivate', 'rsaDecrypt');
        final cipherText = D4.getRequiredArg<Uint8List>(positional, 1, 'cipherText', 'rsaDecrypt');
        return $tom_crypto_4.RsaKeyHelper.rsaDecrypt(myPrivate, cipherText);
      },
      'createUint8ListFromString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createUint8ListFromString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'createUint8ListFromString');
        return $tom_crypto_4.RsaKeyHelper.createUint8ListFromString(s);
      },
      'parsePrivateKeyFromPem': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parsePrivateKeyFromPem');
        final pemString = D4.getRequiredArg<String>(positional, 0, 'pemString', 'parsePrivateKeyFromPem');
        return $tom_crypto_4.RsaKeyHelper.parsePrivateKeyFromPem(pemString);
      },
      'decodePEM': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'decodePEM');
        final pem = D4.getRequiredArg<String>(positional, 0, 'pem', 'decodePEM');
        return $tom_crypto_4.RsaKeyHelper.decodePEM(pem);
      },
      'removePemHeaderAndFooter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'removePemHeaderAndFooter');
        final pem = D4.getRequiredArg<String>(positional, 0, 'pem', 'removePemHeaderAndFooter');
        return $tom_crypto_4.RsaKeyHelper.removePemHeaderAndFooter(pem);
      },
      'encodePrivateKeyToPemPKCS1': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'encodePrivateKeyToPemPKCS1');
        final privateKey = D4.getRequiredArg<dynamic>(positional, 0, 'privateKey', 'encodePrivateKeyToPemPKCS1');
        return $tom_crypto_4.RsaKeyHelper.encodePrivateKeyToPemPKCS1(privateKey);
      },
      'encodePublicKeyToPemPKCS1': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'encodePublicKeyToPemPKCS1');
        final publicKey = D4.getRequiredArg<dynamic>(positional, 0, 'publicKey', 'encodePublicKeyToPemPKCS1');
        return $tom_crypto_4.RsaKeyHelper.encodePublicKeyToPemPKCS1(publicKey);
      },
    },
    constructorSignatures: {
      '': 'RsaKeyHelper()',
    },
    staticMethodSignatures: {
      'computeRSAKeyPair': 'Future<AsymmetricKeyPair<PublicKey, PrivateKey>> computeRSAKeyPair(SecureRandom secureRandom)',
      'getSecureRandom': 'SecureRandom getSecureRandom()',
      'parsePublicKeyFromPem': 'RSAPublicKey parsePublicKeyFromPem(String pemString)',
      'sign': 'String sign(String plainText, RSAPrivateKey privateKey)',
      'rsaEncrypt': 'Uint8List rsaEncrypt(RSAPublicKey myPublic, Uint8List dataToEncrypt)',
      'rsaDecrypt': 'Uint8List rsaDecrypt(RSAPrivateKey myPrivate, Uint8List cipherText)',
      'createUint8ListFromString': 'Uint8List createUint8ListFromString(String s)',
      'parsePrivateKeyFromPem': 'RSAPrivateKey parsePrivateKeyFromPem(String pemString)',
      'decodePEM': 'List<int> decodePEM(String pem)',
      'removePemHeaderAndFooter': 'String removePemHeaderAndFooter(String pem)',
      'encodePrivateKeyToPemPKCS1': 'String encodePrivateKeyToPemPKCS1(RSAPrivateKey privateKey)',
      'encodePublicKeyToPemPKCS1': 'String encodePublicKeyToPemPKCS1(RSAPublicKey publicKey)',
    },
  );
}

// =============================================================================
// TomBeanLocatorException Bridge
// =============================================================================

BridgedClass _createTomBeanLocatorExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_1.TomBeanLocatorException,
    name: 'TomBeanLocatorException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomBeanLocatorException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomBeanLocatorException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomBeanLocatorException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        return $tom_core_kernel_1.TomBeanLocatorException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_1.TomBeanLocatorException>(target, 'TomBeanLocatorException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomBeanLocatorException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomComponent Bridge
// =============================================================================

BridgedClass _createTomComponentBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_1.TomComponent,
    name: 'TomComponent',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomComponent');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'TomComponent');
        return $tom_core_kernel_1.TomComponent(type);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_core_kernel_1.TomComponent>(target, 'TomComponent').type,
    },
    methods: {
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_1.TomComponent>(target, 'TomComponent');
        return t.getType();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_1.TomComponent>(target, 'TomComponent');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TomComponent(Type type)',
    },
    methodSignatures: {
      'getType': 'Type getType()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'Type get type',
    },
  );
}

// =============================================================================
// TomNullInterface Bridge
// =============================================================================

BridgedClass _createTomNullInterfaceBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_1.TomNullInterface,
    name: 'TomNullInterface',
    constructors: {
    },
  );
}

// =============================================================================
// TomNoInterface Bridge
// =============================================================================

BridgedClass _createTomNoInterfaceBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_1.TomNoInterface,
    name: 'TomNoInterface',
    constructors: {
    },
  );
}

// =============================================================================
// TomBean Bridge
// =============================================================================

BridgedClass _createTomBeanBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_1.TomBean,
    name: 'TomBean',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_1.TomBean();
      },
      'fromName': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomBean');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TomBean');
        return $tom_core_kernel_1.TomBean.fromName(name);
      },
      'withName': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomBean');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TomBean');
        final bean = D4.getRequiredArg<Object>(positional, 1, 'bean', 'TomBean');
        return $tom_core_kernel_1.TomBean.withName(name, bean);
      },
      'withType': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomBean');
        final t_ = D4.getRequiredArg<Type>(positional, 0, 't', 'TomBean');
        final bean = D4.getRequiredArg<Object>(positional, 1, 'bean', 'TomBean');
        return $tom_core_kernel_1.TomBean.withType(t_, bean);
      },
    },
    methods: {
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_1.TomBean>(target, 'TomBean');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_1.TomBean>(target, 'TomBean');
        return t.get();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_1.TomBean>(target, 'TomBean');
        return t.call();
      },
      'getBeanType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_1.TomBean>(target, 'TomBean');
        return t.getBeanType();
      },
    },
    staticMethods: {
      'getBeanByType': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getBeanByType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'getBeanByType');
        return $tom_core_kernel_1.TomBean.getBeanByType(type);
      },
      'getBeanByName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getBeanByName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getBeanByName');
        return $tom_core_kernel_1.TomBean.getBeanByName(name);
      },
    },
    constructorSignatures: {
      '': 'TomBean()',
      'fromName': 'factory TomBean.fromName(String name)',
      'withName': 'factory TomBean.withName(String name, Object bean)',
      'withType': 'factory TomBean.withType(Type t, Object bean)',
    },
    methodSignatures: {
      'getType': 'Type getType()',
      'get': 'T get()',
      'call': 'T call()',
      'getBeanType': 'Type getBeanType()',
    },
    staticMethodSignatures: {
      'getBeanByType': 'Object? getBeanByType(Type type)',
      'getBeanByName': 'Object? getBeanByName(String name)',
    },
  );
}

// =============================================================================
// TomExecutionContext Bridge
// =============================================================================

BridgedClass _createTomExecutionContextBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_2.TomExecutionContext,
    name: 'TomExecutionContext',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomExecutionContext');
        if (positional.isEmpty) {
          throw ArgumentError('TomExecutionContext: Missing required argument "contextMap" at position 0');
        }
        final contextMap = D4.coerceMap<String, $tom_core_kernel_2.TomContextEntry>(positional[0], 'contextMap');
        final parentContext = D4.getOptionalNamedArg<$tom_core_kernel_2.TomExecutionContext?>(named, 'parentContext');
        return $tom_core_kernel_2.TomExecutionContext(contextMap, parentContext: parentContext);
      },
    },
    getters: {
      'contextMap': (visitor, target) => D4.validateTarget<$tom_core_kernel_2.TomExecutionContext>(target, 'TomExecutionContext').contextMap,
    },
    methods: {
      'getEntry': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomExecutionContext>(target, 'TomExecutionContext');
        D4.requireMinArgs(positional, 1, 'getEntry');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getEntry');
        return t.getEntry(name);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomExecutionContext>(target, 'TomExecutionContext');
        D4.requireMinArgs(positional, 2, 'add');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'add');
        final entry = D4.getRequiredArg<$tom_core_kernel_2.TomContextEntry>(positional, 1, 'entry', 'add');
        t.add(name, entry);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomExecutionContext>(target, 'TomExecutionContext');
        t.clear();
        return null;
      },
      'combineWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomExecutionContext>(target, 'TomExecutionContext');
        D4.requireMinArgs(positional, 1, 'combineWith');
        final other = D4.getRequiredArg<$tom_core_kernel_2.TomExecutionContext>(positional, 0, 'other', 'combineWith');
        t.combineWith(other);
        return null;
      },
      'runInContext': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomExecutionContext>(target, 'TomExecutionContext');
        D4.requireMinArgs(positional, 1, 'runInContext');
        if (positional.isEmpty) {
          throw ArgumentError('runInContext: Missing required argument "body" at position 0');
        }
        final bodyRaw = positional[0];
        final zoneValues = named.containsKey('zoneValues') && named['zoneValues'] != null
            ? D4.coerceMap<Object?, Object?>(named['zoneValues'], 'zoneValues')
            : const <Object?, Object?>{};
        return t.runInContext(() { return D4.callInterpreterCallback(visitor, bodyRaw, []) as dynamic; }, zoneValues: zoneValues);
      },
      'runInContextAsync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomExecutionContext>(target, 'TomExecutionContext');
        D4.requireMinArgs(positional, 1, 'runInContextAsync');
        if (positional.isEmpty) {
          throw ArgumentError('runInContextAsync: Missing required argument "body" at position 0');
        }
        final bodyRaw = positional[0];
        final zoneValues = named.containsKey('zoneValues') && named['zoneValues'] != null
            ? D4.coerceMap<Object?, Object?>(named['zoneValues'], 'zoneValues')
            : const <Object?, Object?>{};
        return t.runInContextAsync(() { return D4.callInterpreterCallback(visitor, bodyRaw, []) as Future<dynamic>; }, zoneValues: zoneValues);
      },
    },
    staticMethods: {
      'getValueFromCurrentZone': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getValueFromCurrentZone');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getValueFromCurrentZone');
        return $tom_core_kernel_2.TomExecutionContext.getValueFromCurrentZone(name);
      },
    },
    constructorSignatures: {
      '': 'TomExecutionContext(Map<String, TomContextEntry> contextMap, {TomExecutionContext? parentContext})',
    },
    methodSignatures: {
      'getEntry': 'TomContextEntry<T>? getEntry(String name)',
      'add': 'void add(String name, TomContextEntry entry)',
      'clear': 'void clear()',
      'combineWith': 'void combineWith(TomExecutionContext other)',
      'runInContext': 'T runInContext(T Function() body, {Map<Object?, Object?> zoneValues = const {}})',
      'runInContextAsync': 'Future<T> runInContextAsync(Future<T> Function() body, {Map<Object?, Object?> zoneValues = const {}})',
    },
    getterSignatures: {
      'contextMap': 'Map<String, TomContextEntry> get contextMap',
    },
    staticMethodSignatures: {
      'getValueFromCurrentZone': 'T? getValueFromCurrentZone(String name)',
    },
  );
}

// =============================================================================
// TomZoneValues Bridge
// =============================================================================

BridgedClass _createTomZoneValuesBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_2.TomZoneValues,
    name: 'TomZoneValues',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomZoneValues');
        if (positional.isEmpty) {
          throw ArgumentError('TomZoneValues: Missing required argument "zoneValues" at position 0');
        }
        final zoneValues = D4.coerceMapOrNull<Object?, Object?>(positional[0], 'zoneValues');
        final existingValues = D4.getOptionalNamedArg<$tom_core_kernel_2.TomZoneValues?>(named, 'existingValues');
        return $tom_core_kernel_2.TomZoneValues(zoneValues, existingValues: existingValues);
      },
    },
    getters: {
      'zoneValues': (visitor, target) => D4.validateTarget<$tom_core_kernel_2.TomZoneValues>(target, 'TomZoneValues').zoneValues,
    },
    setters: {
      'zoneValues': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_2.TomZoneValues>(target, 'TomZoneValues').zoneValues = (value as Map).cast<Object?, Object?>(),
    },
    methods: {
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomZoneValues>(target, 'TomZoneValues');
        D4.requireMinArgs(positional, 1, 'addAll');
        if (positional.isEmpty) {
          throw ArgumentError('addAll: Missing required argument "other" at position 0');
        }
        final other = D4.coerceMap<Object?, Object?>(positional[0], 'other');
        return t.addAll(other);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomZoneValues>(target, 'TomZoneValues');
        t.clear();
        return null;
      },
      'containsKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomZoneValues>(target, 'TomZoneValues');
        D4.requireMinArgs(positional, 1, 'containsKey');
        final key = D4.getRequiredArg<Object?>(positional, 0, 'key', 'containsKey');
        return t.containsKey(key);
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomZoneValues>(target, 'TomZoneValues');
        D4.requireMinArgs(positional, 1, 'remove');
        final key = D4.getRequiredArg<Object?>(positional, 0, 'key', 'remove');
        return t.remove(key);
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomZoneValues>(target, 'TomZoneValues');
        final index = D4.getRequiredArg<Object?>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomZoneValues>(target, 'TomZoneValues');
        final index = D4.getRequiredArg<Object?>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
    },
    constructorSignatures: {
      '': 'TomZoneValues(Map<Object?, Object?>? zoneValues, {TomZoneValues? existingValues})',
    },
    methodSignatures: {
      'addAll': 'TomZoneValues addAll(Map<Object?, Object?> other)',
      'clear': 'void clear()',
      'containsKey': 'bool containsKey(Object? key)',
      'remove': 'Object? remove(Object? key)',
    },
    getterSignatures: {
      'zoneValues': 'Map<Object?, Object?> get zoneValues',
    },
    setterSignatures: {
      'zoneValues': 'set zoneValues(dynamic value)',
    },
  );
}

// =============================================================================
// TomContextEntry Bridge
// =============================================================================

BridgedClass _createTomContextEntryBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_2.TomContextEntry,
    name: 'TomContextEntry',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomContextEntry');
        if (positional.isEmpty) {
          throw ArgumentError('TomContextEntry: Missing required argument "contextFunction" at position 0');
        }
        final contextFunctionRaw = positional[0];
        return $tom_core_kernel_2.TomContextEntry(() { return D4.callInterpreterCallback(visitor, contextFunctionRaw, []) as dynamic; });
      },
    },
    getters: {
      'contextFunction': (visitor, target) => D4.validateTarget<$tom_core_kernel_2.TomContextEntry>(target, 'TomContextEntry').contextFunction,
      'type': (visitor, target) => D4.validateTarget<$tom_core_kernel_2.TomContextEntry>(target, 'TomContextEntry').type,
      'value': (visitor, target) => D4.validateTarget<$tom_core_kernel_2.TomContextEntry>(target, 'TomContextEntry').value,
    },
    methods: {
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomContextEntry>(target, 'TomContextEntry');
        return t.call();
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_2.TomContextEntry>(target, 'TomContextEntry');
        return ~t;
      },
    },
    constructorSignatures: {
      '': 'const TomContextEntry(T? Function() contextFunction)',
    },
    methodSignatures: {
      'call': 'T? call()',
    },
    getterSignatures: {
      'contextFunction': 'T? Function() get contextFunction',
      'type': 'Type get type',
      'value': 'T? get value',
    },
  );
}

// =============================================================================
// TomContextProviders Bridge
// =============================================================================

BridgedClass _createTomContextProvidersBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_2.TomContextProviders,
    name: 'TomContextProviders',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_2.TomContextProviders();
      },
    },
    staticMethods: {
      'getOrganization': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_2.TomContextProviders.getOrganization();
      },
      'getApplication': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_2.TomContextProviders.getApplication();
      },
      'getProcess': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_2.TomContextProviders.getProcess();
      },
      'getLanguage': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_2.TomContextProviders.getLanguage();
      },
      'getCountry': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_2.TomContextProviders.getCountry();
      },
      'getTimezone': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_2.TomContextProviders.getTimezone();
      },
      'getClientLanguage': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_2.TomContextProviders.getClientLanguage();
      },
      'getClientCountry': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_2.TomContextProviders.getClientCountry();
      },
      'getClientTimezone': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_2.TomContextProviders.getClientTimezone();
      },
    },
    constructorSignatures: {
      '': 'TomContextProviders()',
    },
    staticMethodSignatures: {
      'getOrganization': 'String getOrganization()',
      'getApplication': 'String getApplication()',
      'getProcess': 'String getProcess()',
      'getLanguage': 'String getLanguage()',
      'getCountry': 'String getCountry()',
      'getTimezone': 'String getTimezone()',
      'getClientLanguage': 'String getClientLanguage()',
      'getClientCountry': 'String getClientCountry()',
      'getClientTimezone': 'String getClientTimezone()',
    },
  );
}

// =============================================================================
// TomServerConnectionException Bridge
// =============================================================================

BridgedClass _createTomServerConnectionExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomServerConnectionException,
    name: 'TomServerConnectionException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomServerConnectionException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomServerConnectionException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomServerConnectionException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        final requestUuid = D4.getOptionalNamedArg<String?>(named, 'requestUuid');
        final uuid = D4.getOptionalNamedArg<String?>(named, 'uuid');
        final serverCallError = D4.getOptionalNamedArg<$tom_core_kernel_8.TomServerCallError?>(named, 'serverCallError');
        return $tom_core_kernel_8.TomServerConnectionException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog, requestUuid: requestUuid, uuid: uuid, serverCallError: serverCallError);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerConnectionException>(target, 'TomServerConnectionException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomServerConnectionException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false, String? requestUuid, String? uuid, TomServerCallError? serverCallError})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomRequestAbortedException Bridge
// =============================================================================

BridgedClass _createTomRequestAbortedExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomRequestAbortedException,
    name: 'TomRequestAbortedException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomRequestAbortedException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomRequestAbortedException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomRequestAbortedException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        final requestUuid = D4.getOptionalNamedArg<String?>(named, 'requestUuid');
        return $tom_core_kernel_8.TomRequestAbortedException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog, requestUuid: requestUuid);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomRequestAbortedException>(target, 'TomRequestAbortedException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomRequestAbortedException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false, String? requestUuid})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomServerCallSpecs Bridge
// =============================================================================

BridgedClass _createTomServerCallSpecsBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomServerCallSpecs,
    name: 'TomServerCallSpecs',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomServerCallSpecs');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'TomServerCallSpecs');
        final url = D4.getRequiredArg<Uri>(positional, 1, 'url', 'TomServerCallSpecs');
        final contentLength = D4.getOptionalNamedArg<int?>(named, 'contentLength');
        final followRedirects = D4.getOptionalNamedArg<bool?>(named, 'followRedirects');
        final headers = named.containsKey('headers') && named['headers'] != null
            ? D4.coerceMapOrNull<String, String>(named['headers'], 'headers')
            : const <String, String>{};
        final maxRedirects = D4.getOptionalNamedArg<int?>(named, 'maxRedirects');
        final persistentConnection = D4.getOptionalNamedArg<bool?>(named, 'persistentConnection');
        final includeBearerAuthentication = D4.getNamedArgWithDefault<bool>(named, 'includeBearerAuthentication', true);
        final requestEncoding = D4.getOptionalNamedArg<Encoding?>(named, 'requestEncoding');
        final fallbackResponseEncoding = D4.getOptionalNamedArg<Encoding?>(named, 'fallbackResponseEncoding');
        return $tom_core_kernel_8.TomServerCallSpecs(method, url, contentLength: contentLength, followRedirects: followRedirects, headers: headers, maxRedirects: maxRedirects, persistentConnection: persistentConnection, includeBearerAuthentication: includeBearerAuthentication, requestEncoding: requestEncoding, fallbackResponseEncoding: fallbackResponseEncoding);
      },
    },
    getters: {
      'method': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallSpecs>(target, 'TomServerCallSpecs').method,
      'url': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallSpecs>(target, 'TomServerCallSpecs').url,
      'followRedirects': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallSpecs>(target, 'TomServerCallSpecs').followRedirects,
      'headers': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallSpecs>(target, 'TomServerCallSpecs').headers,
      'maxRedirects': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallSpecs>(target, 'TomServerCallSpecs').maxRedirects,
      'persistentConnection': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallSpecs>(target, 'TomServerCallSpecs').persistentConnection,
      'includeBearerAuthentication': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallSpecs>(target, 'TomServerCallSpecs').includeBearerAuthentication,
      'requestEncoding': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallSpecs>(target, 'TomServerCallSpecs').requestEncoding,
      'fallbackResponseEncoding': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallSpecs>(target, 'TomServerCallSpecs').fallbackResponseEncoding,
    },
    constructorSignatures: {
      '': 'TomServerCallSpecs(String method, Uri url, {int? contentLength, bool? followRedirects, Map<String, String>? headers = const {}, int? maxRedirects, bool? persistentConnection, bool includeBearerAuthentication = true, Encoding? requestEncoding, Encoding? fallbackResponseEncoding})',
    },
    getterSignatures: {
      'method': 'String get method',
      'url': 'Uri get url',
      'followRedirects': 'bool? get followRedirects',
      'headers': 'Map<String, String>? get headers',
      'maxRedirects': 'int? get maxRedirects',
      'persistentConnection': 'bool? get persistentConnection',
      'includeBearerAuthentication': 'bool get includeBearerAuthentication',
      'requestEncoding': 'Encoding? get requestEncoding',
      'fallbackResponseEncoding': 'Encoding? get fallbackResponseEncoding',
    },
  );
}

// =============================================================================
// TomServerCallLoad Bridge
// =============================================================================

BridgedClass _createTomServerCallLoadBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomServerCallLoad,
    name: 'TomServerCallLoad',
    constructors: {
      '': (visitor, positional, named) {
        final stringBody = D4.getOptionalNamedArg<String?>(named, 'stringBody');
        final byteBody = D4.getOptionalNamedArg<Uint8List?>(named, 'byteBody');
        final bodyFields = D4.coerceMapOrNull<String, String>(named['bodyFields'], 'bodyFields');
        final contentType = D4.getOptionalNamedArg<String?>(named, 'contentType');
        final encoding = D4.getOptionalNamedArg<Encoding?>(named, 'encoding');
        final contentLength = D4.getOptionalNamedArg<int?>(named, 'contentLength');
        return $tom_core_kernel_8.TomServerCallLoad(stringBody: stringBody, byteBody: byteBody, bodyFields: bodyFields, contentType: contentType, encoding: encoding, contentLength: contentLength);
      },
    },
    getters: {
      'contentType': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').contentType,
      'encoding': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').encoding,
      'contentLength': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').contentLength,
      'stringBody': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').stringBody,
      'byteBody': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').byteBody,
      'bodyFields': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').bodyFields,
    },
    setters: {
      'contentLength': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').contentLength = value as int?,
      'stringBody': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').stringBody = value as String?,
      'byteBody': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').byteBody = value as Uint8List?,
      'bodyFields': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallLoad>(target, 'TomServerCallLoad').bodyFields = value == null ? null : (value as Map).cast<String, String>(),
    },
    constructorSignatures: {
      '': 'TomServerCallLoad({String? stringBody, Uint8List? byteBody, Map<String, String>? bodyFields, String? contentType, Encoding? encoding, int? contentLength})',
    },
    getterSignatures: {
      'contentType': 'String? get contentType',
      'encoding': 'Encoding? get encoding',
      'contentLength': 'int? get contentLength',
      'stringBody': 'String? get stringBody',
      'byteBody': 'Uint8List? get byteBody',
      'bodyFields': 'Map<String, String>? get bodyFields',
    },
    setterSignatures: {
      'contentLength': 'set contentLength(dynamic value)',
      'stringBody': 'set stringBody(dynamic value)',
      'byteBody': 'set byteBody(dynamic value)',
      'bodyFields': 'set bodyFields(dynamic value)',
    },
  );
}

// =============================================================================
// TomServerCallError Bridge
// =============================================================================

BridgedClass _createTomServerCallErrorBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomServerCallError,
    name: 'TomServerCallError',
    constructors: {
      '': (visitor, positional, named) {
        final statusCode = D4.getNamedArgWithDefault<int>(named, 'statusCode', 200);
        final response = D4.getOptionalNamedArg<String?>(named, 'response');
        final internalError = D4.getNamedArgWithDefault<int>(named, 'internalError', 0);
        final headers = named.containsKey('headers') && named['headers'] != null
            ? D4.coerceMap<String, Object>(named['headers'], 'headers')
            : const <String, Object>{};
        final isRedirect = D4.getNamedArgWithDefault<bool>(named, 'isRedirect', false);
        final reasonPhrase = D4.getOptionalNamedArg<String?>(named, 'reasonPhrase');
        final exception = D4.getOptionalNamedArg<Object?>(named, 'exception');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        final statusCodeResponse = D4.getOptionalNamedArg<Object?>(named, 'statusCodeResponse');
        return $tom_core_kernel_8.TomServerCallError(statusCode: statusCode, response: response, internalError: internalError, headers: headers, isRedirect: isRedirect, reasonPhrase: reasonPhrase, exception: exception, stackTrace: stackTrace, statusCodeResponse: statusCodeResponse);
      },
    },
    getters: {
      'statusCode': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').statusCode,
      'response': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').response,
      'statusCodeResponse': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').statusCodeResponse,
      'internalError': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').internalError,
      'headers': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').headers,
      'isRedirect': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').isRedirect,
      'reasonPhrase': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').reasonPhrase,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').autoLog,
      'clientRethrow': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').clientRethrow,
      'errorKey': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').errorKey,
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').uuid,
      'exception': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').exception,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').requestUuid,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').stackTrace,
      'hasError': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').hasError,
    },
    setters: {
      'statusCode': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').statusCode = value as int,
      'response': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').response = value as String?,
      'statusCodeResponse': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').statusCodeResponse = value as Object?,
      'internalError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').internalError = value as int,
      'headers': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').headers = (value as Map).cast<String, Object>(),
      'isRedirect': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').isRedirect = value as bool,
      'reasonPhrase': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').reasonPhrase = value as String?,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').autoLog = value as bool?,
      'clientRethrow': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').clientRethrow = value as bool?,
      'errorKey': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').errorKey = value as String?,
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').uuid = value as String?,
      'exception': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').exception = value as Object?,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').requestUuid = value as String?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError').stackTrace = value as StackTrace?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCallError>(target, 'TomServerCallError');
        return t.toString();
      },
    },
    staticGetters: {
      'jsonDecodingError': (visitor) => $tom_core_kernel_8.TomServerCallError.jsonDecodingError,
      'noResponseError': (visitor) => $tom_core_kernel_8.TomServerCallError.noResponseError,
      'serverError': (visitor) => $tom_core_kernel_8.TomServerCallError.serverError,
    },
    constructorSignatures: {
      '': 'TomServerCallError({int statusCode = 200, String? response, int internalError = 0, Map<String, Object> headers = const {}, bool isRedirect = false, String? reasonPhrase, Object? exception, StackTrace? stackTrace, Object? statusCodeResponse})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'statusCode': 'int get statusCode',
      'response': 'String? get response',
      'statusCodeResponse': 'Object? get statusCodeResponse',
      'internalError': 'int get internalError',
      'headers': 'Map<String, Object> get headers',
      'isRedirect': 'bool get isRedirect',
      'reasonPhrase': 'String? get reasonPhrase',
      'autoLog': 'bool? get autoLog',
      'clientRethrow': 'bool? get clientRethrow',
      'errorKey': 'String? get errorKey',
      'uuid': 'String? get uuid',
      'exception': 'Object? get exception',
      'requestUuid': 'String? get requestUuid',
      'stackTrace': 'StackTrace? get stackTrace',
      'hasError': 'bool get hasError',
    },
    setterSignatures: {
      'statusCode': 'set statusCode(dynamic value)',
      'response': 'set response(dynamic value)',
      'statusCodeResponse': 'set statusCodeResponse(dynamic value)',
      'internalError': 'set internalError(dynamic value)',
      'headers': 'set headers(dynamic value)',
      'isRedirect': 'set isRedirect(dynamic value)',
      'reasonPhrase': 'set reasonPhrase(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'clientRethrow': 'set clientRethrow(dynamic value)',
      'errorKey': 'set errorKey(dynamic value)',
      'uuid': 'set uuid(dynamic value)',
      'exception': 'set exception(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
    },
    staticGetterSignatures: {
      'jsonDecodingError': 'dynamic get jsonDecodingError',
      'noResponseError': 'dynamic get noResponseError',
      'serverError': 'dynamic get serverError',
    },
  );
}

// =============================================================================
// TomServerCall Bridge
// =============================================================================

BridgedClass _createTomServerCallBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomServerCall,
    name: 'TomServerCall',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomServerCall');
        final client = D4.getRequiredArg<$http_2.Client>(positional, 0, 'client', 'TomServerCall');
        final specs = D4.getRequiredArg<$tom_core_kernel_8.TomServerCallSpecs>(positional, 1, 'specs', 'TomServerCall');
        return $tom_core_kernel_8.TomServerCall(client, specs);
      },
    },
    getters: {
      'client': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').client,
      'specs': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').specs,
      'abortTrigger': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').abortTrigger,
      'abortableRequest': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').abortableRequest,
      'response': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').response,
      'serverResponse': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').serverResponse,
    },
    setters: {
      'client': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').client = value as $http_2.Client,
      'specs': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').specs = value as $tom_core_kernel_8.TomServerCallSpecs,
      'abortTrigger': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').abortTrigger = value as Completer<void>,
      'abortableRequest': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').abortableRequest = value as $http_3.AbortableRequest,
      'response': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').response = value as Future<$http_4.StreamedResponse>?,
      'serverResponse': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall').serverResponse = value as $http_4.StreamedResponse?,
    },
    methods: {
      'applySpecValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        t.applySpecValues();
        return null;
      },
      'applyLoadValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        D4.requireMinArgs(positional, 1, 'applyLoadValues');
        final load = D4.getRequiredArg<$tom_core_kernel_8.TomServerCallLoad>(positional, 0, 'load', 'applyLoadValues');
        t.applyLoadValues(load);
        return null;
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        final stringBody = D4.getOptionalNamedArg<String?>(named, 'stringBody');
        final byteBody = D4.getOptionalNamedArg<Uint8List?>(named, 'byteBody');
        final bodyFields = D4.coerceMapOrNull<String, String>(named['bodyFields'], 'bodyFields');
        t.reset(stringBody: stringBody, byteBody: byteBody, bodyFields: bodyFields);
        return null;
      },
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        D4.requireMinArgs(positional, 1, 'send');
        final load = D4.getRequiredArg<$tom_core_kernel_8.TomServerCallLoad>(positional, 0, 'load', 'send');
        return t.send(load);
      },
      'read': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        return t.read();
      },
      'readAsString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        D4.requireMinArgs(positional, 1, 'readAsString');
        final ec = D4.getRequiredArg<Encoding>(positional, 0, 'ec', 'readAsString');
        return t.readAsString(ec);
      },
      'getResponseHeaders': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        return t.getResponseHeaders();
      },
      'getResponseStatusCode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        return t.getResponseStatusCode();
      },
      'getResponseContentLength': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        return t.getResponseContentLength();
      },
      'getResponseIsRedirect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        return t.getResponseIsRedirect();
      },
      'getResponseReasonPhrase': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        return t.getResponseReasonPhrase();
      },
      'getResponseRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        return t.getResponseRequest();
      },
      'abort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerCall>(target, 'TomServerCall');
        t.abort();
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomServerCall(Client client, TomServerCallSpecs specs)',
    },
    methodSignatures: {
      'applySpecValues': 'void applySpecValues()',
      'applyLoadValues': 'void applyLoadValues(TomServerCallLoad load)',
      'reset': 'void reset({String? stringBody, Uint8List? byteBody, Map<String, String>? bodyFields})',
      'send': 'TomServerCall send(TomServerCallLoad load)',
      'read': 'Future<Uint8List> read()',
      'readAsString': 'Future<String> readAsString(Encoding ec)',
      'getResponseHeaders': 'Future<Map<String, String>> getResponseHeaders()',
      'getResponseStatusCode': 'Future<int> getResponseStatusCode()',
      'getResponseContentLength': 'Future<int?> getResponseContentLength()',
      'getResponseIsRedirect': 'Future<bool> getResponseIsRedirect()',
      'getResponseReasonPhrase': 'Future<String?> getResponseReasonPhrase()',
      'getResponseRequest': 'Future<BaseRequest?> getResponseRequest()',
      'abort': 'void abort()',
    },
    getterSignatures: {
      'client': 'Client get client',
      'specs': 'TomServerCallSpecs get specs',
      'abortTrigger': 'Completer<void> get abortTrigger',
      'abortableRequest': 'AbortableRequest get abortableRequest',
      'response': 'Future<StreamedResponse>? get response',
      'serverResponse': 'StreamedResponse? get serverResponse',
    },
    setterSignatures: {
      'client': 'set client(dynamic value)',
      'specs': 'set specs(dynamic value)',
      'abortTrigger': 'set abortTrigger(dynamic value)',
      'abortableRequest': 'set abortableRequest(dynamic value)',
      'response': 'set response(dynamic value)',
      'serverResponse': 'set serverResponse(dynamic value)',
    },
  );
}

// =============================================================================
// TomServerChannel Bridge
// =============================================================================

BridgedClass _createTomServerChannelBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomServerChannel,
    name: 'TomServerChannel',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomServerChannel');
        final host = D4.getRequiredArg<String>(positional, 0, 'host', 'TomServerChannel');
        final port = D4.getRequiredArg<int>(positional, 1, 'port', 'TomServerChannel');
        final clientFactory = D4.getOptionalNamedArg<$tom_core_kernel_8.TomHttpClientFactory?>(named, 'clientFactory');
        return $tom_core_kernel_8.TomServerChannel(host, port, clientFactory: clientFactory);
      },
    },
    getters: {
      'client': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel').client,
      'host': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel').host,
      'port': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel').port,
      'clientFactory': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel').clientFactory,
    },
    setters: {
      'client': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel').client = value as $http_2.Client?,
      'host': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel').host = value as String,
      'port': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel').port = value as int,
      'clientFactory': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel').clientFactory = value as $tom_core_kernel_8.TomHttpClientFactory,
    },
    methods: {
      'prepareCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel');
        D4.requireMinArgs(positional, 1, 'prepareCall');
        final spec = D4.getRequiredArg<$tom_core_kernel_8.TomServerCallSpecs>(positional, 0, 'spec', 'prepareCall');
        return t.prepareCall(spec);
      },
      'getClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel');
        return t.getClient();
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerChannel>(target, 'TomServerChannel');
        t.close();
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomServerChannel(String host, int port, {TomHttpClientFactory? clientFactory})',
    },
    methodSignatures: {
      'prepareCall': 'TomServerCall prepareCall(TomServerCallSpecs spec)',
      'getClient': 'Client getClient()',
      'close': 'void close()',
    },
    getterSignatures: {
      'client': 'Client? get client',
      'host': 'String get host',
      'port': 'int get port',
      'clientFactory': 'TomHttpClientFactory get clientFactory',
    },
    setterSignatures: {
      'client': 'set client(dynamic value)',
      'host': 'set host(dynamic value)',
      'port': 'set port(dynamic value)',
      'clientFactory': 'set clientFactory(dynamic value)',
    },
  );
}

// =============================================================================
// TomHttpClientFactory Bridge
// =============================================================================

BridgedClass _createTomHttpClientFactoryBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomHttpClientFactory,
    name: 'TomHttpClientFactory',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_8.TomHttpClientFactory();
      },
    },
    getters: {
      'instanceClientFactory': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomHttpClientFactory>(target, 'TomHttpClientFactory').instanceClientFactory,
    },
    setters: {
      'instanceClientFactory': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomHttpClientFactory>(target, 'TomHttpClientFactory').instanceClientFactory = value as $tom_core_kernel_8.TomHttpClientFactory?,
    },
    methods: {
      'getClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomHttpClientFactory>(target, 'TomHttpClientFactory');
        return t.getClient();
      },
    },
    staticMethods: {
      'setGlobalHttpClientFactory': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setGlobalHttpClientFactory');
        final factory = D4.getRequiredArg<$tom_core_kernel_8.TomHttpClientFactory>(positional, 0, 'factory', 'setGlobalHttpClientFactory');
        return $tom_core_kernel_8.TomHttpClientFactory.setGlobalHttpClientFactory(factory);
      },
      'initialize': (visitor, positional, named, typeArgs) {
        final defaultFactory = D4.getOptionalArg<$tom_core_kernel_8.TomHttpClientFactory?>(positional, 0, 'defaultFactory');
        return $tom_core_kernel_8.TomHttpClientFactory.initialize(defaultFactory);
      },
    },
    constructorSignatures: {
      '': 'TomHttpClientFactory()',
    },
    methodSignatures: {
      'getClient': 'Client getClient()',
    },
    getterSignatures: {
      'instanceClientFactory': 'TomHttpClientFactory? get instanceClientFactory',
    },
    setterSignatures: {
      'instanceClientFactory': 'set instanceClientFactory(dynamic value)',
    },
    staticMethodSignatures: {
      'setGlobalHttpClientFactory': 'void setGlobalHttpClientFactory(TomHttpClientFactory factory)',
      'initialize': 'void initialize([TomHttpClientFactory? defaultFactory])',
    },
  );
}

// =============================================================================
// TomHttpClientAbstractFactory Bridge
// =============================================================================

BridgedClass _createTomHttpClientAbstractFactoryBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomHttpClientAbstractFactory,
    name: 'TomHttpClientAbstractFactory',
    constructors: {
    },
    methods: {
      'getClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomHttpClientAbstractFactory>(target, 'TomHttpClientAbstractFactory');
        return t.getClient();
      },
    },
    methodSignatures: {
      'getClient': 'Client getClient()',
    },
  );
}

// =============================================================================
// TomDefaultHttpClientFactory Bridge
// =============================================================================

BridgedClass _createTomDefaultHttpClientFactoryBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomDefaultHttpClientFactory,
    name: 'TomDefaultHttpClientFactory',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_8.TomDefaultHttpClientFactory();
      },
    },
    getters: {
      'instanceClientFactory': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomDefaultHttpClientFactory>(target, 'TomDefaultHttpClientFactory').instanceClientFactory,
    },
    setters: {
      'instanceClientFactory': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomDefaultHttpClientFactory>(target, 'TomDefaultHttpClientFactory').instanceClientFactory = value as $tom_core_kernel_8.TomHttpClientFactory?,
    },
    methods: {
      'getClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomDefaultHttpClientFactory>(target, 'TomDefaultHttpClientFactory');
        return t.getClient();
      },
    },
    constructorSignatures: {
      '': 'TomDefaultHttpClientFactory()',
    },
    methodSignatures: {
      'getClient': 'Client getClient()',
    },
    getterSignatures: {
      'instanceClientFactory': 'TomHttpClientFactory? get instanceClientFactory',
    },
    setterSignatures: {
      'instanceClientFactory': 'set instanceClientFactory(dynamic value)',
    },
  );
}

// =============================================================================
// TomServerEndpoint Bridge
// =============================================================================

BridgedClass _createTomServerEndpointBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_8.TomServerEndpoint,
    name: 'TomServerEndpoint',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomServerEndpoint');
        final channel = D4.getRequiredArg<$tom_core_kernel_8.TomServerChannel>(positional, 0, 'channel', 'TomServerEndpoint');
        final specs = D4.getRequiredArg<$tom_core_kernel_8.TomServerCallSpecs>(positional, 1, 'specs', 'TomServerEndpoint');
        final statusCodeResponseTypes = D4.coerceMapOrNull<int, Type>(named['statusCodeResponseTypes'], 'statusCodeResponseTypes');
        return $tom_core_kernel_8.TomServerEndpoint(channel, specs, statusCodeResponseTypes: statusCodeResponseTypes);
      },
    },
    getters: {
      'channel': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerEndpoint>(target, 'TomServerEndpoint').channel,
      'specs': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerEndpoint>(target, 'TomServerEndpoint').specs,
      'statusCodeResponseTypes': (visitor, target) => D4.validateTarget<$tom_core_kernel_8.TomServerEndpoint>(target, 'TomServerEndpoint').statusCodeResponseTypes,
    },
    setters: {
      'channel': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerEndpoint>(target, 'TomServerEndpoint').channel = value as $tom_core_kernel_8.TomServerChannel,
      'specs': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerEndpoint>(target, 'TomServerEndpoint').specs = value as $tom_core_kernel_8.TomServerCallSpecs,
      'statusCodeResponseTypes': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_8.TomServerEndpoint>(target, 'TomServerEndpoint').statusCodeResponseTypes = value == null ? null : (value as Map).cast<int, Type>(),
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_8.TomServerEndpoint>(target, 'TomServerEndpoint');
        D4.requireMinArgs(positional, 1, 'send');
        final load = D4.getRequiredArg<Object>(positional, 0, 'load', 'send');
        final responseObject = D4.getOptionalArg<Object>(positional, 1, 'responseObject');
        return t.send(load, responseObject);
      },
    },
    staticMethods: {
      'createApiServerEndpoint': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createApiServerEndpoint');
        final apiEndpoint = D4.getRequiredArg<$tom_core_kernel_3.TomApiEndpoint>(positional, 0, 'apiEndpoint', 'createApiServerEndpoint');
        final specs = D4.getOptionalNamedArg<$tom_core_kernel_8.TomServerCallSpecs?>(named, 'specs');
        final channel = D4.getOptionalNamedArg<$tom_core_kernel_8.TomServerChannel?>(named, 'channel');
        final baseUri = D4.getOptionalNamedArg<Uri?>(named, 'baseUri');
        return $tom_core_kernel_8.TomServerEndpoint.createApiServerEndpoint(apiEndpoint, specs: specs, channel: channel, baseUri: baseUri);
      },
      'removeLeadingSlash': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'removeLeadingSlash');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'removeLeadingSlash');
        return $tom_core_kernel_8.TomServerEndpoint.removeLeadingSlash(s);
      },
    },
    constructorSignatures: {
      '': 'TomServerEndpoint(TomServerChannel channel, TomServerCallSpecs specs, {Map<int, Type>? statusCodeResponseTypes})',
    },
    methodSignatures: {
      'send': 'Future<(R result, TomServerCallError? ts)> send(T load, [R? responseObject])',
    },
    getterSignatures: {
      'channel': 'TomServerChannel get channel',
      'specs': 'TomServerCallSpecs get specs',
      'statusCodeResponseTypes': 'Map<int, Type>? get statusCodeResponseTypes',
    },
    setterSignatures: {
      'channel': 'set channel(dynamic value)',
      'specs': 'set specs(dynamic value)',
      'statusCodeResponseTypes': 'set statusCodeResponseTypes(dynamic value)',
    },
    staticMethodSignatures: {
      'createApiServerEndpoint': 'TomServerEndpoint<requestType, responseType> createApiServerEndpoint(TomApiEndpoint apiEndpoint, {TomServerCallSpecs? specs, TomServerChannel? channel, Uri? baseUri})',
      'removeLeadingSlash': 'String removeLeadingSlash(String s)',
    },
  );
}

// =============================================================================
// TomEndpointException Bridge
// =============================================================================

BridgedClass _createTomEndpointExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_3.TomEndpointException,
    name: 'TomEndpointException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomEndpointException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomEndpointException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomEndpointException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        final uuid = D4.getOptionalNamedArg<String?>(named, 'uuid');
        final serverCallError = D4.getOptionalNamedArg<$tom_core_kernel_8.TomServerCallError?>(named, 'serverCallError');
        return $tom_core_kernel_3.TomEndpointException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog, uuid: uuid, serverCallError: serverCallError);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_3.TomEndpointException>(target, 'TomEndpointException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomEndpointException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false, String? uuid, TomServerCallError? serverCallError})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomContentDisposition Bridge
// =============================================================================

BridgedClass _createTomContentDispositionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_3.TomContentDisposition,
    name: 'TomContentDisposition',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_3.TomContentDisposition();
      },
    },
    staticGetters: {
      'attachment': (visitor) => $tom_core_kernel_3.TomContentDisposition.attachment,
    },
    staticSetters: {
      'attachment': (visitor, value) => 
        $tom_core_kernel_3.TomContentDisposition.attachment = value as String,
    },
    constructorSignatures: {
      '': 'TomContentDisposition()',
    },
    staticGetterSignatures: {
      'attachment': 'String get attachment',
    },
    staticSetterSignatures: {
      'attachment': 'set attachment(dynamic value)',
    },
  );
}

// =============================================================================
// TomRemoteApis Bridge
// =============================================================================

BridgedClass _createTomRemoteApisBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_3.TomRemoteApis,
    name: 'TomRemoteApis',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_3.TomRemoteApis();
      },
    },
    getters: {
      'apis': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomRemoteApis>(target, 'TomRemoteApis').apis,
    },
    methods: {
      'register': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_3.TomRemoteApis>(target, 'TomRemoteApis');
        D4.requireMinArgs(positional, 1, 'register');
        final api = D4.getRequiredArg<$tom_core_kernel_3.TomApi>(positional, 0, 'api', 'register');
        t.register(api);
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_3.TomRemoteApis>(target, 'TomRemoteApis');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_3.TomRemoteApis>(target, 'TomRemoteApis');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<$tom_core_kernel_3.TomApi>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    staticGetters: {
      'current': (visitor) => $tom_core_kernel_3.TomRemoteApis.current,
    },
    staticMethods: {
      'registerApi': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'registerApi');
        final api = D4.getRequiredArg<$tom_core_kernel_3.TomApi>(positional, 0, 'api', 'registerApi');
        return $tom_core_kernel_3.TomRemoteApis.registerApi(api);
      },
      'getApiById': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getApiById');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'getApiById');
        return $tom_core_kernel_3.TomRemoteApis.getApiById(id);
      },
    },
    constructorSignatures: {
      '': 'TomRemoteApis()',
    },
    methodSignatures: {
      'register': 'void register(TomApi api)',
    },
    getterSignatures: {
      'apis': 'Map<String, TomApi> get apis',
    },
    staticMethodSignatures: {
      'registerApi': 'void registerApi(TomApi api)',
      'getApiById': 'TomApi getApiById(String id)',
    },
    staticGetterSignatures: {
      'current': 'TomRemoteApis get current',
    },
  );
}

// =============================================================================
// TomApi Bridge
// =============================================================================

BridgedClass _createTomApiBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_3.TomApi,
    name: 'TomApi',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'TomApi');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final uri = D4.getOptionalNamedArg<String?>(named, 'uri');
        if (!named.containsKey('endpoints') || named['endpoints'] == null) {
          throw ArgumentError('TomApi: Missing required named argument "endpoints"');
        }
        final endpoints = D4.coerceList<$tom_core_kernel_3.TomApiEndpoint>(named['endpoints'], 'endpoints');
        final requestEncoding = D4.getOptionalNamedArg<Encoding?>(named, 'requestEncoding');
        final responseEncoding = D4.getOptionalNamedArg<Encoding?>(named, 'responseEncoding');
        final statusCodeResponseTypes = D4.coerceMapOrNull<int, Type>(named['statusCodeResponseTypes'], 'statusCodeResponseTypes');
        return $tom_core_kernel_3.TomApi(id: id, name: name, description: description, uri: uri, endpoints: endpoints, requestEncoding: requestEncoding, responseEncoding: responseEncoding, statusCodeResponseTypes: statusCodeResponseTypes);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi').id,
      'name': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi').name,
      'description': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi').description,
      'uri': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi').uri,
      'requestEncoding': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi').requestEncoding,
      'responseEncoding': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi').responseEncoding,
      'statusCodeResponseTypes': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi').statusCodeResponseTypes,
      'endpoints': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi').endpoints,
    },
    methods: {
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_3.TomApi>(target, 'TomApi');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<$tom_core_kernel_3.TomApiEndpoint>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomApi({required String id, String? name, String? description, String? uri, required List<TomApiEndpoint> endpoints, Encoding? requestEncoding, Encoding? responseEncoding, Map<int, Type>? statusCodeResponseTypes})',
    },
    getterSignatures: {
      'id': 'String get id',
      'name': 'String? get name',
      'description': 'String? get description',
      'uri': 'String? get uri',
      'requestEncoding': 'Encoding? get requestEncoding',
      'responseEncoding': 'Encoding? get responseEncoding',
      'statusCodeResponseTypes': 'Map<int, Type>? get statusCodeResponseTypes',
      'endpoints': 'Map<String, TomApiEndpoint> get endpoints',
    },
  );
}

// =============================================================================
// TomApiEndpoint Bridge
// =============================================================================

BridgedClass _createTomApiEndpointBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_3.TomApiEndpoint,
    name: 'TomApiEndpoint',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'TomApiEndpoint');
        final uri = D4.getOptionalNamedArg<String?>(named, 'uri');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final methods = D4.coerceListOrNull<$tom_core_kernel_5.TomHttpMethod>(named['methods'], 'methods');
        final method = D4.getRequiredNamedArg<$tom_core_kernel_5.TomHttpMethod>(named, 'method', 'TomApiEndpoint');
        final consumes = D4.getNamedArgWithDefault<$tom_core_kernel_6.TomMimeType>(named, 'consumes', $tom_core_kernel_6.TomMimeType.json);
        final produces = D4.getNamedArgWithDefault<$tom_core_kernel_6.TomMimeType>(named, 'produces', $tom_core_kernel_6.TomMimeType.json);
        final contentDisposition = D4.getOptionalNamedArg<String?>(named, 'contentDisposition');
        final formFields = named.containsKey('formFields') && named['formFields'] != null
            ? D4.coerceList<String>(named['formFields'], 'formFields')
            : const <String>[];
        final responseHeaders = named.containsKey('responseHeaders') && named['responseHeaders'] != null
            ? D4.coerceMap<String, String>(named['responseHeaders'], 'responseHeaders')
            : const <String, String>{};
        final requestHeaders = named.containsKey('requestHeaders') && named['requestHeaders'] != null
            ? D4.coerceMap<String, String>(named['requestHeaders'], 'requestHeaders')
            : const <String, String>{};
        final requestTypes = D4.coerceListOrNull<Type>(named['requestTypes'], 'requestTypes');
        final followRedirects = D4.getNamedArgWithDefault<bool>(named, 'followRedirects', false);
        final persistentConnection = D4.getOptionalNamedArg<bool?>(named, 'persistentConnection');
        final includeBearerAuthentication = D4.getNamedArgWithDefault<bool>(named, 'includeBearerAuthentication', true);
        final maxRedirects = D4.getOptionalNamedArg<int?>(named, 'maxRedirects');
        final requestEncoding = D4.getOptionalNamedArg<Encoding?>(named, 'requestEncoding');
        final responseEncoding = D4.getOptionalNamedArg<Encoding?>(named, 'responseEncoding');
        final statusCodeResponseTypes = D4.coerceMapOrNull<int, Type>(named['statusCodeResponseTypes'], 'statusCodeResponseTypes');
        return $tom_core_kernel_3.TomApiEndpoint(id: id, uri: uri, description: description, methods: methods, method: method, consumes: consumes, produces: produces, contentDisposition: contentDisposition, formFields: formFields, responseHeaders: responseHeaders, requestHeaders: requestHeaders, requestTypes: requestTypes, followRedirects: followRedirects, persistentConnection: persistentConnection, includeBearerAuthentication: includeBearerAuthentication, maxRedirects: maxRedirects, requestEncoding: requestEncoding, responseEncoding: responseEncoding, statusCodeResponseTypes: statusCodeResponseTypes);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').id,
      'uri': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').uri,
      'description': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').description,
      'methods': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').methods,
      'method': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').method,
      'consumes': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').consumes,
      'produces': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').produces,
      'contentDisposition': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').contentDisposition,
      'requestTypes': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').requestTypes,
      'responseType': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').responseType,
      'formFields': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').formFields,
      'responseHeaders': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').responseHeaders,
      'requestHeaders': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').requestHeaders,
      'followRedirects': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').followRedirects,
      'maxRedirects': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').maxRedirects,
      'persistentConnection': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').persistentConnection,
      'includeBearerAuthentication': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').includeBearerAuthentication,
      'requestEncoding': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').requestEncoding,
      'responseEncoding': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').responseEncoding,
      'statusCodeResponseTypes': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').statusCodeResponseTypes,
      'api': (visitor, target) => D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').api,
    },
    setters: {
      'requestTypes': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').requestTypes = (value as List).cast<Type>().toList(),
      'responseType': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_3.TomApiEndpoint>(target, 'TomApiEndpoint').responseType = value as Type,
    },
    constructorSignatures: {
      '': 'TomApiEndpoint({required String id, String? uri, String? description, List<TomHttpMethod>? methods, required TomHttpMethod method, TomMimeType consumes = TomMimeType.json, TomMimeType produces = TomMimeType.json, String? contentDisposition, List<String> formFields = const [], Map<String, String> responseHeaders = const {}, Map<String, String> requestHeaders = const {}, List<Type>? requestTypes, bool followRedirects = false, bool? persistentConnection, bool includeBearerAuthentication = true, int? maxRedirects, Encoding? requestEncoding, Encoding? responseEncoding, Map<int, Type>? statusCodeResponseTypes})',
    },
    getterSignatures: {
      'id': 'String get id',
      'uri': 'String? get uri',
      'description': 'String? get description',
      'methods': 'List<TomHttpMethod>? get methods',
      'method': 'TomHttpMethod get method',
      'consumes': 'TomMimeType get consumes',
      'produces': 'TomMimeType get produces',
      'contentDisposition': 'String? get contentDisposition',
      'requestTypes': 'List<Type> get requestTypes',
      'responseType': 'Type get responseType',
      'formFields': 'List<String> get formFields',
      'responseHeaders': 'Map<String, String> get responseHeaders',
      'requestHeaders': 'Map<String, String> get requestHeaders',
      'followRedirects': 'bool get followRedirects',
      'maxRedirects': 'int? get maxRedirects',
      'persistentConnection': 'bool? get persistentConnection',
      'includeBearerAuthentication': 'bool get includeBearerAuthentication',
      'requestEncoding': 'Encoding? get requestEncoding',
      'responseEncoding': 'Encoding? get responseEncoding',
      'statusCodeResponseTypes': 'Map<int, Type>? get statusCodeResponseTypes',
      'api': 'TomApi get api',
    },
    setterSignatures: {
      'requestTypes': 'set requestTypes(dynamic value)',
      'responseType': 'set responseType(dynamic value)',
    },
  );
}

// =============================================================================
// TomClientRemoteContextException Bridge
// =============================================================================

BridgedClass _createTomClientRemoteContextExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_7.TomClientRemoteContextException,
    name: 'TomClientRemoteContextException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomClientRemoteContextException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomClientRemoteContextException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomClientRemoteContextException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        final uuid = D4.getOptionalNamedArg<String?>(named, 'uuid');
        final serverCallError = D4.getOptionalNamedArg<$tom_core_kernel_8.TomServerCallError?>(named, 'serverCallError');
        return $tom_core_kernel_7.TomClientRemoteContextException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog, uuid: uuid, serverCallError: serverCallError);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContextException>(target, 'TomClientRemoteContextException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomClientRemoteContextException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false, String? uuid, TomServerCallError? serverCallError})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomClientRemoteContext Bridge
// =============================================================================

BridgedClass _createTomClientRemoteContextBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_7.TomClientRemoteContext,
    name: 'TomClientRemoteContext',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomClientRemoteContext');
        final baseUri = D4.getRequiredArg<Uri>(positional, 0, 'baseUri', 'TomClientRemoteContext');
        final authenticationUri = D4.getOptionalArg<Uri?>(positional, 1, 'authenticationUri');
        return $tom_core_kernel_7.TomClientRemoteContext(baseUri, authenticationUri);
      },
    },
    getters: {
      'authenticationUri': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContext>(target, 'TomClientRemoteContext').authenticationUri,
      'baseUri': (visitor, target) => D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContext>(target, 'TomClientRemoteContext').baseUri,
    },
    setters: {
      'authenticationUri': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContext>(target, 'TomClientRemoteContext').authenticationUri = value as Uri,
      'baseUri': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContext>(target, 'TomClientRemoteContext').baseUri = value as Uri,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_7.TomClientRemoteContext>(target, 'TomClientRemoteContext');
        return t.toString();
      },
    },
    staticGetters: {
      'current': (visitor) => $tom_core_kernel_7.TomClientRemoteContext.current,
    },
    staticMethods: {
      'setCurrent': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setCurrent');
        final context = D4.getRequiredArg<$tom_core_kernel_7.TomClientRemoteContext>(positional, 0, 'context', 'setCurrent');
        return $tom_core_kernel_7.TomClientRemoteContext.setCurrent(context);
      },
    },
    staticSetters: {
      'current': (visitor, value) => 
        $tom_core_kernel_7.TomClientRemoteContext.current = value as $tom_core_kernel_7.TomClientRemoteContext?,
    },
    constructorSignatures: {
      '': 'TomClientRemoteContext(Uri baseUri, [Uri? authenticationUri])',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'authenticationUri': 'Uri get authenticationUri',
      'baseUri': 'Uri get baseUri',
    },
    setterSignatures: {
      'authenticationUri': 'set authenticationUri(dynamic value)',
      'baseUri': 'set baseUri(dynamic value)',
    },
    staticMethodSignatures: {
      'setCurrent': 'void setCurrent(TomClientRemoteContext context)',
    },
    staticGetterSignatures: {
      'current': 'TomClientRemoteContext? get current',
    },
    staticSetterSignatures: {
      'current': 'set current(dynamic value)',
    },
  );
}

// =============================================================================
// TomHttpMethod Bridge
// =============================================================================

BridgedClass _createTomHttpMethodBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_5.TomHttpMethod,
    name: 'TomHttpMethod',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomHttpMethod');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TomHttpMethod');
        final acceptsBody = D4.getOptionalArgWithDefault<bool>(positional, 1, 'acceptsBody', true);
        return $tom_core_kernel_5.TomHttpMethod(name, acceptsBody);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_core_kernel_5.TomHttpMethod>(target, 'TomHttpMethod').name,
      'acceptsBody': (visitor, target) => D4.validateTarget<$tom_core_kernel_5.TomHttpMethod>(target, 'TomHttpMethod').acceptsBody,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_5.TomHttpMethod>(target, 'TomHttpMethod');
        return t.toString();
      },
    },
    staticGetters: {
      'methods': (visitor) => $tom_core_kernel_5.TomHttpMethod.methods,
      'head': (visitor) => $tom_core_kernel_5.TomHttpMethod.head,
      'get': (visitor) => $tom_core_kernel_5.TomHttpMethod.get,
      'post': (visitor) => $tom_core_kernel_5.TomHttpMethod.post,
      'put': (visitor) => $tom_core_kernel_5.TomHttpMethod.put,
      'patch': (visitor) => $tom_core_kernel_5.TomHttpMethod.patch,
      'delete': (visitor) => $tom_core_kernel_5.TomHttpMethod.delete,
      'connect': (visitor) => $tom_core_kernel_5.TomHttpMethod.connect,
      'trace': (visitor) => $tom_core_kernel_5.TomHttpMethod.trace,
      'options': (visitor) => $tom_core_kernel_5.TomHttpMethod.options,
      'all': (visitor) => $tom_core_kernel_5.TomHttpMethod.all,
    },
    staticSetters: {
      'methods': (visitor, value) => 
        $tom_core_kernel_5.TomHttpMethod.methods = (value as Map).cast<String, $tom_core_kernel_5.TomHttpMethod>(),
    },
    constructorSignatures: {
      '': 'const TomHttpMethod(String name, [bool acceptsBody = true])',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'acceptsBody': 'bool get acceptsBody',
    },
    staticGetterSignatures: {
      'methods': 'Map<String, TomHttpMethod> get methods',
      'head': 'TomHttpMethod get head',
      'get': 'TomHttpMethod get get',
      'post': 'TomHttpMethod get post',
      'put': 'TomHttpMethod get put',
      'patch': 'TomHttpMethod get patch',
      'delete': 'TomHttpMethod get delete',
      'connect': 'TomHttpMethod get connect',
      'trace': 'TomHttpMethod get trace',
      'options': 'TomHttpMethod get options',
      'all': 'TomHttpMethod get all',
    },
    staticSetterSignatures: {
      'methods': 'set methods(dynamic value)',
    },
  );
}

// =============================================================================
// TomMimeTypeException Bridge
// =============================================================================

BridgedClass _createTomMimeTypeExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_6.TomMimeTypeException,
    name: 'TomMimeTypeException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomMimeTypeException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomMimeTypeException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomMimeTypeException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        return $tom_core_kernel_6.TomMimeTypeException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_6.TomMimeTypeException>(target, 'TomMimeTypeException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomMimeTypeException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomMimeType Bridge
// =============================================================================

BridgedClass _createTomMimeTypeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_6.TomMimeType,
    name: 'TomMimeType',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomMimeType');
        final primaryType = D4.getRequiredArg<String>(positional, 0, 'primaryType', 'TomMimeType');
        final subType = D4.getRequiredArg<String>(positional, 1, 'subType', 'TomMimeType');
        final charset = D4.getNamedArgWithDefault<String?>(named, 'charset', "UTF-8");
        final codecs = named.containsKey('codecs') && named['codecs'] != null
            ? D4.coerceList<String>(named['codecs'], 'codecs')
            : const <String>[];
        return $tom_core_kernel_6.TomMimeType(primaryType, subType, charset: charset, codecs: codecs);
      },
      'parse': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomMimeType');
        final type = D4.getRequiredArg<String>(positional, 0, 'type', 'TomMimeType');
        return $tom_core_kernel_6.TomMimeType.parse(type);
      },
    },
    getters: {
      'primaryType': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType').primaryType,
      'subType': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType').subType,
      'charset': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType').charset,
      'codecs': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType').codecs,
      'isText': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType').isText,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType').hashCode,
    },
    methods: {
      'toHeaderValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType');
        return t.toHeaderValue();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType');
        return t.toString();
      },
      'isEqualType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType');
        D4.requireMinArgs(positional, 1, 'isEqualType');
        final other = D4.getRequiredArg<$tom_core_kernel_6.TomMimeType>(positional, 0, 'other', 'isEqualType');
        return t.isEqualType(other);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_6.TomMimeType>(target, 'TomMimeType');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'none': (visitor) => $tom_core_kernel_6.TomMimeType.none,
      'plainText': (visitor) => $tom_core_kernel_6.TomMimeType.plainText,
      'ics': (visitor) => $tom_core_kernel_6.TomMimeType.ics,
      'html': (visitor) => $tom_core_kernel_6.TomMimeType.html,
      'css': (visitor) => $tom_core_kernel_6.TomMimeType.css,
      'csv': (visitor) => $tom_core_kernel_6.TomMimeType.csv,
      'javascript': (visitor) => $tom_core_kernel_6.TomMimeType.javascript,
      'json': (visitor) => $tom_core_kernel_6.TomMimeType.json,
      'xml': (visitor) => $tom_core_kernel_6.TomMimeType.xml,
      'octetStream': (visitor) => $tom_core_kernel_6.TomMimeType.octetStream,
      'pdf': (visitor) => $tom_core_kernel_6.TomMimeType.pdf,
      'rtf': (visitor) => $tom_core_kernel_6.TomMimeType.rtf,
      'pkcs8': (visitor) => $tom_core_kernel_6.TomMimeType.pkcs8,
      'zip': (visitor) => $tom_core_kernel_6.TomMimeType.zip,
      'multipartFormData': (visitor) => $tom_core_kernel_6.TomMimeType.multipartFormData,
      'multipartByteranges': (visitor) => $tom_core_kernel_6.TomMimeType.multipartByteranges,
      'urlEncoded': (visitor) => $tom_core_kernel_6.TomMimeType.urlEncoded,
    },
    constructorSignatures: {
      '': 'const TomMimeType(String primaryType, String subType, {String? charset = "UTF-8", List<String> codecs = const []})',
      'parse': 'factory TomMimeType.parse(String type)',
    },
    methodSignatures: {
      'toHeaderValue': 'String toHeaderValue()',
      'toString': 'String toString()',
      'isEqualType': 'bool isEqualType(TomMimeType other)',
    },
    getterSignatures: {
      'primaryType': 'String get primaryType',
      'subType': 'String get subType',
      'charset': 'String? get charset',
      'codecs': 'List<String> get codecs',
      'isText': 'bool get isText',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'none': 'dynamic get none',
      'plainText': 'dynamic get plainText',
      'ics': 'dynamic get ics',
      'html': 'dynamic get html',
      'css': 'dynamic get css',
      'csv': 'dynamic get csv',
      'javascript': 'dynamic get javascript',
      'json': 'dynamic get json',
      'xml': 'dynamic get xml',
      'octetStream': 'dynamic get octetStream',
      'pdf': 'dynamic get pdf',
      'rtf': 'dynamic get rtf',
      'pkcs8': 'dynamic get pkcs8',
      'zip': 'dynamic get zip',
      'multipartFormData': 'dynamic get multipartFormData',
      'multipartByteranges': 'dynamic get multipartByteranges',
      'urlEncoded': 'dynamic get urlEncoded',
    },
  );
}

// =============================================================================
// StaticFileMimetypeMapping Bridge
// =============================================================================

BridgedClass _createStaticFileMimetypeMappingBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_6.StaticFileMimetypeMapping,
    name: 'StaticFileMimetypeMapping',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_6.StaticFileMimetypeMapping();
      },
    },
    staticMethods: {
      'getMimeType': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getMimeType');
        final extension = D4.getRequiredArg<String>(positional, 0, 'extension', 'getMimeType');
        return $tom_core_kernel_6.StaticFileMimetypeMapping.getMimeType(extension);
      },
    },
    constructorSignatures: {
      '': 'StaticFileMimetypeMapping()',
    },
    staticMethodSignatures: {
      'getMimeType': 'TomMimeType? getMimeType(String extension)',
    },
  );
}

// =============================================================================
// TomHeader Bridge
// =============================================================================

BridgedClass _createTomHeaderBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_4.TomHeader,
    name: 'TomHeader',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_4.TomHeader();
      },
    },
    staticGetters: {
      'contentType': (visitor) => $tom_core_kernel_4.TomHeader.contentType,
      'contentDisposition': (visitor) => $tom_core_kernel_4.TomHeader.contentDisposition,
    },
    constructorSignatures: {
      '': 'TomHeader()',
    },
    staticGetterSignatures: {
      'contentType': 'dynamic get contentType',
      'contentDisposition': 'dynamic get contentDisposition',
    },
  );
}

// =============================================================================
// TomWorkerException Bridge
// =============================================================================

BridgedClass _createTomWorkerExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_9.TomWorkerException,
    name: 'TomWorkerException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomWorkerException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomWorkerException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomWorkerException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        final uuid = D4.getOptionalNamedArg<String?>(named, 'uuid');
        final serverCallError = D4.getOptionalNamedArg<$tom_core_kernel_8.TomServerCallError?>(named, 'serverCallError');
        return $tom_core_kernel_9.TomWorkerException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog, uuid: uuid, serverCallError: serverCallError);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomWorkerException>(target, 'TomWorkerException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomWorkerException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false, String? uuid, TomServerCallError? serverCallError})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomExecutor Bridge
// =============================================================================

BridgedClass _createTomExecutorBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_9.TomExecutor,
    name: 'TomExecutor',
    constructors: {
    },
    methods: {
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomExecutor>(target, 'TomExecutor');
        D4.requireMinArgs(positional, 1, 'execute');
        final command = D4.getRequiredArg<Object>(positional, 0, 'command', 'execute');
        return t.execute(command);
      },
    },
    staticGetters: {
      'noResult': (visitor) => $tom_core_kernel_9.TomExecutor.noResult,
    },
    methodSignatures: {
      'execute': 'Object execute(Object command)',
    },
    staticGetterSignatures: {
      'noResult': 'Object get noResult',
    },
  );
}

// =============================================================================
// TomCommand Bridge
// =============================================================================

BridgedClass _createTomCommandBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_9.TomCommand,
    name: 'TomCommand',
    constructors: {
    },
    methods: {
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomCommand>(target, 'TomCommand');
        return t.execute();
      },
    },
    methodSignatures: {
      'execute': 'Future<Object?> execute()',
    },
  );
}

// =============================================================================
// TomWorkerContext Bridge
// =============================================================================

BridgedClass _createTomWorkerContextBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_9.TomWorkerContext,
    name: 'TomWorkerContext',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'TomWorkerContext');
        final tomEnvironment = D4.getRequiredArg<$tom_basics_3.TomEnvironment>(positional, 0, 'tomEnvironment', 'TomWorkerContext');
        final tomPlatform = D4.getRequiredArg<$tom_basics_3.TomPlatform>(positional, 1, 'tomPlatform', 'TomWorkerContext');
        if (positional.length <= 2) {
          throw ArgumentError('TomWorkerContext: Missing required argument "args" at position 2');
        }
        final args = D4.coerceList<String>(positional[2], 'args');
        final namePrefix = D4.getRequiredArg<String>(positional, 3, 'namePrefix', 'TomWorkerContext');
        return $tom_core_kernel_9.TomWorkerContext(tomEnvironment, tomPlatform, args, namePrefix);
      },
    },
    getters: {
      'tomEnvironment': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext').tomEnvironment,
      'tomPlatform': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext').tomPlatform,
      'args': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext').args,
      'namePrefix': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext').namePrefix,
    },
    setters: {
      'tomEnvironment': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext').tomEnvironment = value as $tom_basics_3.TomEnvironment,
      'tomPlatform': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext').tomPlatform = value as $tom_basics_3.TomPlatform,
      'args': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext').args = (value as List).cast<String>().toList(),
      'namePrefix': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext').namePrefix = value as String,
    },
    methods: {
      'initializeIsolate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext');
        return t.initializeIsolate();
      },
      'initializeWorker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomWorkerContext>(target, 'TomWorkerContext');
        D4.requireMinArgs(positional, 1, 'initializeWorker');
        final worker = D4.getRequiredArg<$tom_core_kernel_9.TomWorker>(positional, 0, 'worker', 'initializeWorker');
        return t.initializeWorker(worker);
      },
    },
    constructorSignatures: {
      '': 'TomWorkerContext(TomEnvironment tomEnvironment, TomPlatform tomPlatform, List<String> args, String namePrefix)',
    },
    methodSignatures: {
      'initializeIsolate': 'Future<bool> initializeIsolate()',
      'initializeWorker': 'Future<bool> initializeWorker(TomWorker worker)',
    },
    getterSignatures: {
      'tomEnvironment': 'TomEnvironment get tomEnvironment',
      'tomPlatform': 'TomPlatform get tomPlatform',
      'args': 'List<String> get args',
      'namePrefix': 'String get namePrefix',
    },
    setterSignatures: {
      'tomEnvironment': 'set tomEnvironment(dynamic value)',
      'tomPlatform': 'set tomPlatform(dynamic value)',
      'args': 'set args(dynamic value)',
      'namePrefix': 'set namePrefix(dynamic value)',
    },
  );
}

// =============================================================================
// TomWorker Bridge
// =============================================================================

BridgedClass _createTomWorkerBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_9.TomWorker,
    name: 'TomWorker',
    constructors: {
    },
    getters: {
      'isReady': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorker>(target, 'TomWorker').isReady,
      'isClosed': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorker>(target, 'TomWorker').isClosed,
      'isolate': (visitor, target) => D4.validateTarget<$tom_core_kernel_9.TomWorker>(target, 'TomWorker').isolate,
    },
    setters: {
      'isReady': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_9.TomWorker>(target, 'TomWorker').isReady = value as bool,
    },
    methods: {
      'isBusy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomWorker>(target, 'TomWorker');
        return t.isBusy();
      },
      'executeCommand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomWorker>(target, 'TomWorker');
        D4.requireMinArgs(positional, 1, 'executeCommand');
        final command = D4.getRequiredArg<Object>(positional, 0, 'command', 'executeCommand');
        return t.executeCommand(command);
      },
      'sendExecutorToIsolate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomWorker>(target, 'TomWorker');
        D4.requireMinArgs(positional, 1, 'sendExecutorToIsolate');
        final te = D4.getRequiredArg<$tom_core_kernel_9.TomExecutor>(positional, 0, 'te', 'sendExecutorToIsolate');
        t.sendExecutorToIsolate(te);
        return null;
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomWorker>(target, 'TomWorker');
        t.close();
        return null;
      },
    },
    staticGetters: {
      'workerCount': (visitor) => $tom_core_kernel_9.TomWorker.workerCount,
      'isMainIsolate': (visitor) => $tom_core_kernel_9.TomWorker.isMainIsolate,
      'readyMessage': (visitor) => $tom_core_kernel_9.TomWorker.readyMessage,
      'executors': (visitor) => $tom_core_kernel_9.TomWorker.executors,
    },
    staticMethods: {
      'spawn': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'spawn');
        if (positional.isEmpty) {
          throw ArgumentError('spawn: Missing required argument "initializer" at position 0');
        }
        final initializerRaw = positional[0];
        final initializer = ($tom_core_kernel_9.TomWorkerContext p0) { D4.callInterpreterCallback(visitor, initializerRaw, [p0]); };
        final workerContext = D4.getRequiredArg<$tom_core_kernel_9.TomWorkerContext>(positional, 1, 'workerContext', 'spawn');
        return $tom_core_kernel_9.TomWorker.spawn(initializer, workerContext);
      },
      'startRemoteIsolate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'startRemoteIsolate');
        final context = D4.getRequiredArg<$tom_core_kernel_9.TomWorkerContext>(positional, 0, 'context', 'startRemoteIsolate');
        return $tom_core_kernel_9.TomWorker.startRemoteIsolate(context);
      },
      'canSendToCreator': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_9.TomWorker.canSendToCreator();
      },
      'sendToCreator': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sendToCreator');
        final o = D4.getRequiredArg<Object>(positional, 0, 'o', 'sendToCreator');
        return $tom_core_kernel_9.TomWorker.sendToCreator(o);
      },
      'executeInCreator': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'executeInCreator');
        final command = D4.getRequiredArg<Object>(positional, 0, 'command', 'executeInCreator');
        return $tom_core_kernel_9.TomWorker.executeInCreator(command);
      },
    },
    staticSetters: {
      'workerCount': (visitor, value) => 
        $tom_core_kernel_9.TomWorker.workerCount = value as int,
      'isMainIsolate': (visitor, value) => 
        $tom_core_kernel_9.TomWorker.isMainIsolate = value as bool,
      'executors': (visitor, value) => 
        $tom_core_kernel_9.TomWorker.executors = (value as List).cast<$tom_core_kernel_9.TomExecutor>().toList(),
    },
    methodSignatures: {
      'isBusy': 'bool isBusy()',
      'executeCommand': 'Future<Object?> executeCommand(Object command)',
      'sendExecutorToIsolate': 'void sendExecutorToIsolate(TomExecutor te)',
      'close': 'void close()',
    },
    getterSignatures: {
      'isReady': 'bool get isReady',
      'isClosed': 'bool get isClosed',
      'isolate': 'Isolate get isolate',
    },
    setterSignatures: {
      'isReady': 'set isReady(dynamic value)',
    },
    staticMethodSignatures: {
      'spawn': 'Future<TomWorker> spawn(void Function(TomWorkerContext) initializer, TomWorkerContext workerContext)',
      'startRemoteIsolate': 'void startRemoteIsolate(TomWorkerContext context)',
      'canSendToCreator': 'bool canSendToCreator()',
      'sendToCreator': 'void sendToCreator(Object o)',
      'executeInCreator': 'Future<Object?> executeInCreator(Object command)',
    },
    staticGetterSignatures: {
      'workerCount': 'int get workerCount',
      'isMainIsolate': 'bool get isMainIsolate',
      'readyMessage': 'dynamic get readyMessage',
      'executors': 'List<TomExecutor> get executors',
    },
    staticSetterSignatures: {
      'workerCount': 'set workerCount(dynamic value)',
      'isMainIsolate': 'set isMainIsolate(dynamic value)',
      'executors': 'set executors(dynamic value)',
    },
  );
}

// =============================================================================
// TomWorkerPool Bridge
// =============================================================================

BridgedClass _createTomWorkerPoolBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_9.TomWorkerPool,
    name: 'TomWorkerPool',
    constructors: {
    },
    methods: {
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_9.TomWorkerPool>(target, 'TomWorkerPool');
        D4.requireMinArgs(positional, 1, 'execute');
        final command = D4.getRequiredArg<Object>(positional, 0, 'command', 'execute');
        return t.execute(command);
      },
    },
    staticMethods: {
      'withSize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'withSize');
        final size = D4.getRequiredArg<int>(positional, 0, 'size', 'withSize');
        final context = D4.getRequiredArg<$tom_core_kernel_9.TomWorkerContext>(positional, 1, 'context', 'withSize');
        return $tom_core_kernel_9.TomWorkerPool.withSize(size, context);
      },
    },
    methodSignatures: {
      'execute': 'Object? execute(Object command)',
    },
    staticMethodSignatures: {
      'withSize': 'Future<TomWorkerPool> withSize(int size, TomWorkerContext context)',
    },
  );
}

// =============================================================================
// TomException Bridge
// =============================================================================

BridgedClass _createTomExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_12.TomException,
    name: 'TomException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomException');
        final requestUuid = D4.getOptionalNamedArg<String?>(named, 'requestUuid');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final uuid = D4.getOptionalNamedArg<String?>(named, 'uuid');
        final serverCallError = D4.getOptionalNamedArg<$tom_core_kernel_8.TomServerCallError?>(named, 'serverCallError');
        return $tom_core_kernel_12.TomException(key, defaultUserMessage, requestUuid: requestUuid, parameters: parameters, rootException: rootException, autoLog: autoLog, stack: stack, uuid: uuid, serverCallError: serverCallError);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_12.TomException>(target, 'TomException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomException(String key, String defaultUserMessage, {String? requestUuid, Map<String, Object?>? parameters, Object? rootException, bool autoLog = false, Object? stack, String? uuid, TomServerCallError? serverCallError})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomLoggingExecutor Bridge
// =============================================================================

BridgedClass _createTomLoggingExecutorBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_15.TomLoggingExecutor,
    name: 'TomLoggingExecutor',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_15.TomLoggingExecutor();
      },
    },
    methods: {
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_15.TomLoggingExecutor>(target, 'TomLoggingExecutor');
        D4.requireMinArgs(positional, 1, 'execute');
        final command = D4.getRequiredArg<Object>(positional, 0, 'command', 'execute');
        return t.execute(command);
      },
    },
    constructorSignatures: {
      '': 'TomLoggingExecutor()',
    },
    methodSignatures: {
      'execute': 'Object execute(Object command)',
    },
  );
}

// =============================================================================
// TomInterIsolateLogMessage Bridge
// =============================================================================

BridgedClass _createTomInterIsolateLogMessageBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_15.TomInterIsolateLogMessage,
    name: 'TomInterIsolateLogMessage',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 7, 'TomInterIsolateLogMessage');
        final loggerLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'loggerLevel', 'TomInterIsolateLogMessage');
        final logLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'logLevel', 'TomInterIsolateLogMessage');
        final level = D4.getRequiredArg<String>(positional, 2, 'level', 'TomInterIsolateLogMessage');
        final message = D4.getRequiredArg<String>(positional, 3, 'message', 'TomInterIsolateLogMessage');
        final isolateName = D4.getRequiredArg<String>(positional, 4, 'isolateName', 'TomInterIsolateLogMessage');
        final timeStamp = D4.getRequiredArg<DateTime>(positional, 5, 'timeStamp', 'TomInterIsolateLogMessage');
        final origin = D4.getRequiredArg<String?>(positional, 6, 'origin', 'TomInterIsolateLogMessage');
        return $tom_core_kernel_15.TomInterIsolateLogMessage(loggerLevel, logLevel, level, message, isolateName, timeStamp, origin);
      },
    },
    getters: {
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').timeStamp,
      'loggerLevel': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').loggerLevel,
      'logLevel': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').logLevel,
      'level': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').level,
      'message': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').message,
      'isolateName': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').isolateName,
      'origin': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').origin,
    },
    setters: {
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').timeStamp = value as DateTime,
      'loggerLevel': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').loggerLevel = value as $tom_basics_2.TomLogLevel,
      'logLevel': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').logLevel = value as $tom_basics_2.TomLogLevel,
      'level': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').level = value as String,
      'message': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').message = value as String,
      'isolateName': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').isolateName = value as String,
      'origin': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage').origin = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_15.TomInterIsolateLogMessage>(target, 'TomInterIsolateLogMessage');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TomInterIsolateLogMessage(TomLogLevel loggerLevel, TomLogLevel logLevel, String level, String message, String isolateName, DateTime timeStamp, String? origin)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'timeStamp': 'DateTime get timeStamp',
      'loggerLevel': 'TomLogLevel get loggerLevel',
      'logLevel': 'TomLogLevel get logLevel',
      'level': 'String get level',
      'message': 'String get message',
      'isolateName': 'String get isolateName',
      'origin': 'String? get origin',
    },
    setterSignatures: {
      'timeStamp': 'set timeStamp(dynamic value)',
      'loggerLevel': 'set loggerLevel(dynamic value)',
      'logLevel': 'set logLevel(dynamic value)',
      'level': 'set level(dynamic value)',
      'message': 'set message(dynamic value)',
      'isolateName': 'set isolateName(dynamic value)',
      'origin': 'set origin(dynamic value)',
    },
  );
}

// =============================================================================
// TomIsolateLogOutput Bridge
// =============================================================================

BridgedClass _createTomIsolateLogOutputBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_15.TomIsolateLogOutput,
    name: 'TomIsolateLogOutput',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomIsolateLogOutput');
        final workerPool = D4.getRequiredArg<$tom_core_kernel_9.TomWorkerPool>(positional, 0, 'workerPool', 'TomIsolateLogOutput');
        return $tom_core_kernel_15.TomIsolateLogOutput(workerPool);
      },
    },
    getters: {
      'workerPool': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomIsolateLogOutput>(target, 'TomIsolateLogOutput').workerPool,
    },
    setters: {
      'workerPool': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomIsolateLogOutput>(target, 'TomIsolateLogOutput').workerPool = value as $tom_core_kernel_9.TomWorkerPool,
    },
    methods: {
      'output': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_15.TomIsolateLogOutput>(target, 'TomIsolateLogOutput');
        D4.requireMinArgs(positional, 6, 'output');
        final loggerLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'loggerLevel', 'output');
        final logLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'logLevel', 'output');
        final level = D4.getRequiredArg<String>(positional, 2, 'level', 'output');
        final message = D4.getRequiredArg<Object>(positional, 3, 'message', 'output');
        final isolateName = D4.getRequiredArg<String>(positional, 4, 'isolateName', 'output');
        final timeStamp = D4.getRequiredArg<DateTime>(positional, 5, 'timeStamp', 'output');
        final origin = D4.getOptionalArg<String?>(positional, 6, 'origin');
        t.output(loggerLevel, logLevel, level, message, isolateName, timeStamp, origin);
        return null;
      },
      'convertToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_15.TomIsolateLogOutput>(target, 'TomIsolateLogOutput');
        D4.requireMinArgs(positional, 1, 'convertToString');
        final message = D4.getRequiredArg<Object>(positional, 0, 'message', 'convertToString');
        return t.convertToString(message);
      },
    },
    constructorSignatures: {
      '': 'TomIsolateLogOutput(TomWorkerPool workerPool)',
    },
    methodSignatures: {
      'output': 'void output(TomLogLevel loggerLevel, TomLogLevel logLevel, String level, Object message, String isolateName, DateTime timeStamp, [String? origin])',
      'convertToString': 'String convertToString(Object message)',
    },
    getterSignatures: {
      'workerPool': 'TomWorkerPool get workerPool',
    },
    setterSignatures: {
      'workerPool': 'set workerPool(dynamic value)',
    },
  );
}

// =============================================================================
// TomCreatorLogOutput Bridge
// =============================================================================

BridgedClass _createTomCreatorLogOutputBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_15.TomCreatorLogOutput,
    name: 'TomCreatorLogOutput',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_15.TomCreatorLogOutput();
      },
    },
    methods: {
      'output': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_15.TomCreatorLogOutput>(target, 'TomCreatorLogOutput');
        D4.requireMinArgs(positional, 6, 'output');
        final loggerLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'loggerLevel', 'output');
        final logLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'logLevel', 'output');
        final level = D4.getRequiredArg<String>(positional, 2, 'level', 'output');
        final message = D4.getRequiredArg<Object>(positional, 3, 'message', 'output');
        final isolateName = D4.getRequiredArg<String>(positional, 4, 'isolateName', 'output');
        final timeStamp = D4.getRequiredArg<DateTime>(positional, 5, 'timeStamp', 'output');
        final origin = D4.getOptionalArg<String?>(positional, 6, 'origin');
        t.output(loggerLevel, logLevel, level, message, isolateName, timeStamp, origin);
        return null;
      },
      'convertToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_15.TomCreatorLogOutput>(target, 'TomCreatorLogOutput');
        D4.requireMinArgs(positional, 1, 'convertToString');
        final message = D4.getRequiredArg<Object>(positional, 0, 'message', 'convertToString');
        return t.convertToString(message);
      },
    },
    staticGetters: {
      'fallbackOutput': (visitor) => $tom_core_kernel_15.TomCreatorLogOutput.fallbackOutput,
    },
    staticSetters: {
      'fallbackOutput': (visitor, value) => 
        $tom_core_kernel_15.TomCreatorLogOutput.fallbackOutput = value as $tom_basics_2.TomConsoleLogOutput,
    },
    constructorSignatures: {
      '': 'TomCreatorLogOutput()',
    },
    methodSignatures: {
      'output': 'void output(TomLogLevel loggerLevel, TomLogLevel logLevel, String level, Object message, String isolateName, DateTime timeStamp, [String? origin])',
      'convertToString': 'String convertToString(Object message)',
    },
    staticGetterSignatures: {
      'fallbackOutput': 'TomConsoleLogOutput get fallbackOutput',
    },
    staticSetterSignatures: {
      'fallbackOutput': 'set fallbackOutput(dynamic value)',
    },
  );
}

// =============================================================================
// TomLoggingWorkerContext Bridge
// =============================================================================

BridgedClass _createTomLoggingWorkerContextBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_15.TomLoggingWorkerContext,
    name: 'TomLoggingWorkerContext',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'TomLoggingWorkerContext');
        final tomEnvironment = D4.getRequiredArg<$tom_basics_3.TomEnvironment>(positional, 0, 'tomEnvironment', 'TomLoggingWorkerContext');
        final tomPlatform = D4.getRequiredArg<$tom_basics_3.TomPlatform>(positional, 1, 'tomPlatform', 'TomLoggingWorkerContext');
        if (positional.length <= 2) {
          throw ArgumentError('TomLoggingWorkerContext: Missing required argument "args" at position 2');
        }
        final args = D4.coerceList<String>(positional[2], 'args');
        final namePrefix = D4.getRequiredArg<String>(positional, 3, 'namePrefix', 'TomLoggingWorkerContext');
        return $tom_core_kernel_15.TomLoggingWorkerContext(tomEnvironment, tomPlatform, args, namePrefix);
      },
    },
    getters: {
      'tomEnvironment': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext').tomEnvironment,
      'tomPlatform': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext').tomPlatform,
      'args': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext').args,
      'namePrefix': (visitor, target) => D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext').namePrefix,
    },
    setters: {
      'tomEnvironment': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext').tomEnvironment = value as $tom_basics_3.TomEnvironment,
      'tomPlatform': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext').tomPlatform = value as $tom_basics_3.TomPlatform,
      'args': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext').args = (value as List).cast<String>().toList(),
      'namePrefix': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext').namePrefix = value as String,
    },
    methods: {
      'initializeIsolate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext');
        return t.initializeIsolate();
      },
      'initializeWorker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_15.TomLoggingWorkerContext>(target, 'TomLoggingWorkerContext');
        D4.requireMinArgs(positional, 1, 'initializeWorker');
        final worker = D4.getRequiredArg<$tom_core_kernel_9.TomWorker>(positional, 0, 'worker', 'initializeWorker');
        return t.initializeWorker(worker);
      },
    },
    constructorSignatures: {
      '': 'TomLoggingWorkerContext(TomEnvironment tomEnvironment, TomPlatform tomPlatform, List<String> args, String namePrefix)',
    },
    methodSignatures: {
      'initializeIsolate': 'Future<bool> initializeIsolate()',
      'initializeWorker': 'Future<bool> initializeWorker(TomWorker worker)',
    },
    getterSignatures: {
      'tomEnvironment': 'TomEnvironment get tomEnvironment',
      'tomPlatform': 'TomPlatform get tomPlatform',
      'args': 'List<String> get args',
      'namePrefix': 'String get namePrefix',
    },
    setterSignatures: {
      'tomEnvironment': 'set tomEnvironment(dynamic value)',
      'tomPlatform': 'set tomPlatform(dynamic value)',
      'args': 'set args(dynamic value)',
      'namePrefix': 'set namePrefix(dynamic value)',
    },
  );
}

// =============================================================================
// TomIsolateLogging Bridge
// =============================================================================

BridgedClass _createTomIsolateLoggingBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_15.TomIsolateLogging,
    name: 'TomIsolateLogging',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_15.TomIsolateLogging();
      },
    },
    staticMethods: {
      'startIsolatedLogging': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'startIsolatedLogging');
        if (positional.isEmpty) {
          throw ArgumentError('startIsolatedLogging: Missing required argument "args" at position 0');
        }
        final args = D4.coerceList<String>(positional[0], 'args');
        final poolSize = D4.getNamedArgWithDefault<int>(named, 'poolSize', 1);
        final workerContext = D4.getOptionalNamedArg<$tom_core_kernel_15.TomLoggingWorkerContext?>(named, 'workerContext');
        return $tom_core_kernel_15.TomIsolateLogging.startIsolatedLogging(args, poolSize: poolSize, workerContext: workerContext);
      },
      'startLoggingToCreator': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_15.TomIsolateLogging.startLoggingToCreator();
      },
    },
    constructorSignatures: {
      '': 'TomIsolateLogging()',
    },
    staticMethodSignatures: {
      'startIsolatedLogging': 'Future<bool> startIsolatedLogging(List<String> args, {int poolSize = 1, TomLoggingWorkerContext? workerContext})',
      'startLoggingToCreator': 'void startLoggingToCreator()',
    },
  );
}

// =============================================================================
// TomRemoteLogMessage Bridge
// =============================================================================

BridgedClass _createTomRemoteLogMessageBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_16.TomRemoteLogMessage,
    name: 'TomRemoteLogMessage',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_16.TomRemoteLogMessage();
      },
      'of': (visitor, positional, named) {
        D4.requireMinArgs(positional, 7, 'TomRemoteLogMessage');
        final loggerLevel = D4.getRequiredArg<int>(positional, 0, 'loggerLevel', 'TomRemoteLogMessage');
        final logLevel = D4.getRequiredArg<int>(positional, 1, 'logLevel', 'TomRemoteLogMessage');
        final level = D4.getRequiredArg<String>(positional, 2, 'level', 'TomRemoteLogMessage');
        final message = D4.getRequiredArg<String>(positional, 3, 'message', 'TomRemoteLogMessage');
        final isolateName = D4.getRequiredArg<String>(positional, 4, 'isolateName', 'TomRemoteLogMessage');
        final timeStamp = D4.getRequiredArg<String>(positional, 5, 'timeStamp', 'TomRemoteLogMessage');
        final origin = D4.getRequiredArg<String?>(positional, 6, 'origin', 'TomRemoteLogMessage');
        return $tom_core_kernel_16.TomRemoteLogMessage.of(loggerLevel, logLevel, level, message, isolateName, timeStamp, origin);
      },
    },
    getters: {
      'sender': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').sender,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').timeStamp,
      'loggerLevel': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').loggerLevel,
      'logLevel': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').logLevel,
      'level': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').level,
      'message': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').message,
      'isolateName': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').isolateName,
      'origin': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').origin,
    },
    setters: {
      'sender': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').sender = value as String,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').timeStamp = value as String,
      'loggerLevel': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').loggerLevel = value as int,
      'logLevel': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').logLevel = value as int,
      'level': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').level = value as String,
      'message': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').message = value as String,
      'isolateName': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').isolateName = value as String,
      'origin': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage').origin = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_16.TomRemoteLogMessage>(target, 'TomRemoteLogMessage');
        return t.toString();
      },
    },
    staticGetters: {
      'globalSettingSenderId': (visitor) => $tom_core_kernel_16.TomRemoteLogMessage.globalSettingSenderId,
    },
    staticSetters: {
      'globalSettingSenderId': (visitor, value) => 
        $tom_core_kernel_16.TomRemoteLogMessage.globalSettingSenderId = value as String,
    },
    constructorSignatures: {
      '': 'TomRemoteLogMessage()',
      'of': 'TomRemoteLogMessage.of(int loggerLevel, int logLevel, String level, String message, String isolateName, String timeStamp, String? origin)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'sender': 'String get sender',
      'timeStamp': 'String get timeStamp',
      'loggerLevel': 'int get loggerLevel',
      'logLevel': 'int get logLevel',
      'level': 'String get level',
      'message': 'String get message',
      'isolateName': 'String get isolateName',
      'origin': 'String? get origin',
    },
    setterSignatures: {
      'sender': 'set sender(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'loggerLevel': 'set loggerLevel(dynamic value)',
      'logLevel': 'set logLevel(dynamic value)',
      'level': 'set level(dynamic value)',
      'message': 'set message(dynamic value)',
      'isolateName': 'set isolateName(dynamic value)',
      'origin': 'set origin(dynamic value)',
    },
    staticGetterSignatures: {
      'globalSettingSenderId': 'String get globalSettingSenderId',
    },
    staticSetterSignatures: {
      'globalSettingSenderId': 'set globalSettingSenderId(dynamic value)',
    },
  );
}

// =============================================================================
// TomRemoteLogResult Bridge
// =============================================================================

BridgedClass _createTomRemoteLogResultBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_16.TomRemoteLogResult,
    name: 'TomRemoteLogResult',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_16.TomRemoteLogResult();
      },
      'withError': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomRemoteLogResult');
        final errorMessage = D4.getRequiredArg<String>(positional, 0, 'errorMessage', 'TomRemoteLogResult');
        return $tom_core_kernel_16.TomRemoteLogResult.withError(errorMessage);
      },
    },
    getters: {
      'hasError': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogResult>(target, 'TomRemoteLogResult').hasError,
      'errorMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomRemoteLogResult>(target, 'TomRemoteLogResult').errorMessage,
    },
    setters: {
      'hasError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogResult>(target, 'TomRemoteLogResult').hasError = value as bool,
      'errorMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomRemoteLogResult>(target, 'TomRemoteLogResult').errorMessage = value as String,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_16.TomRemoteLogResult>(target, 'TomRemoteLogResult');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TomRemoteLogResult()',
      'withError': 'TomRemoteLogResult.withError(String errorMessage)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hasError': 'bool get hasError',
      'errorMessage': 'String get errorMessage',
    },
    setterSignatures: {
      'hasError': 'set hasError(dynamic value)',
      'errorMessage': 'set errorMessage(dynamic value)',
    },
  );
}

// =============================================================================
// TomLoggingContext Bridge
// =============================================================================

BridgedClass _createTomLoggingContextBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_16.TomLoggingContext,
    name: 'TomLoggingContext',
    constructors: {
      '': (visitor, positional, named) {
        final inRemoteLogging = D4.getNamedArgWithDefault<bool>(named, 'inRemoteLogging', false);
        return $tom_core_kernel_16.TomLoggingContext(inRemoteLogging: inRemoteLogging);
      },
    },
    getters: {
      'inRemoteLogging': (visitor, target) => D4.validateTarget<$tom_core_kernel_16.TomLoggingContext>(target, 'TomLoggingContext').inRemoteLogging,
    },
    setters: {
      'inRemoteLogging': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_16.TomLoggingContext>(target, 'TomLoggingContext').inRemoteLogging = value as bool,
    },
    constructorSignatures: {
      '': 'TomLoggingContext({bool inRemoteLogging = false})',
    },
    getterSignatures: {
      'inRemoteLogging': 'bool get inRemoteLogging',
    },
    setterSignatures: {
      'inRemoteLogging': 'set inRemoteLogging(dynamic value)',
    },
  );
}

// =============================================================================
// TomRemoteLogOutput Bridge
// =============================================================================

BridgedClass _createTomRemoteLogOutputBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_16.TomRemoteLogOutput,
    name: 'TomRemoteLogOutput',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_16.TomRemoteLogOutput();
      },
    },
    methods: {
      'output': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_16.TomRemoteLogOutput>(target, 'TomRemoteLogOutput');
        D4.requireMinArgs(positional, 6, 'output');
        final loggerLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'loggerLevel', 'output');
        final logLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'logLevel', 'output');
        final level = D4.getRequiredArg<String>(positional, 2, 'level', 'output');
        final message = D4.getRequiredArg<Object>(positional, 3, 'message', 'output');
        final isolateName = D4.getRequiredArg<String>(positional, 4, 'isolateName', 'output');
        final timeStamp = D4.getRequiredArg<DateTime>(positional, 5, 'timeStamp', 'output');
        final origin = D4.getOptionalArg<String?>(positional, 6, 'origin');
        t.output(loggerLevel, logLevel, level, message, isolateName, timeStamp, origin);
        return null;
      },
      'convertToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_16.TomRemoteLogOutput>(target, 'TomRemoteLogOutput');
        D4.requireMinArgs(positional, 1, 'convertToString');
        final message = D4.getRequiredArg<Object>(positional, 0, 'message', 'convertToString');
        return t.convertToString(message);
      },
    },
    staticGetters: {
      'globalSettingFallbackOutput': (visitor) => $tom_core_kernel_16.TomRemoteLogOutput.globalSettingFallbackOutput,
      'remoteEndpoint': (visitor) => $tom_core_kernel_16.TomRemoteLogOutput.remoteEndpoint,
    },
    staticSetters: {
      'globalSettingFallbackOutput': (visitor, value) => 
        $tom_core_kernel_16.TomRemoteLogOutput.globalSettingFallbackOutput = value as $tom_basics_2.TomLogOutput,
      'remoteEndpoint': (visitor, value) => 
        $tom_core_kernel_16.TomRemoteLogOutput.remoteEndpoint = value as $tom_core_kernel_8.TomServerEndpoint<$tom_core_kernel_16.TomRemoteLogMessage, $tom_core_kernel_16.TomRemoteLogResult>?,
    },
    constructorSignatures: {
      '': 'TomRemoteLogOutput()',
    },
    methodSignatures: {
      'output': 'void output(TomLogLevel loggerLevel, TomLogLevel logLevel, String level, Object message, String isolateName, DateTime timeStamp, [String? origin])',
      'convertToString': 'String convertToString(Object message)',
    },
    staticGetterSignatures: {
      'globalSettingFallbackOutput': 'TomLogOutput get globalSettingFallbackOutput',
      'remoteEndpoint': 'TomServerEndpoint<TomRemoteLogMessage, TomRemoteLogResult>? get remoteEndpoint',
    },
    staticSetterSignatures: {
      'globalSettingFallbackOutput': 'set globalSettingFallbackOutput(dynamic value)',
      'remoteEndpoint': 'set remoteEndpoint(dynamic value)',
    },
  );
}

// =============================================================================
// TomRemoteLogServer Bridge
// =============================================================================

BridgedClass _createTomRemoteLogServerBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_17.TomRemoteLogServer,
    name: 'TomRemoteLogServer',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_17.TomRemoteLogServer();
      },
    },
    methods: {
      'receive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_17.TomRemoteLogServer>(target, 'TomRemoteLogServer');
        D4.requireMinArgs(positional, 1, 'receive');
        final m = D4.getRequiredArg<$tom_core_kernel_16.TomRemoteLogMessage>(positional, 0, 'm', 'receive');
        return t.receive(m);
      },
    },
    staticGetters: {
      'localOutput': (visitor) => $tom_core_kernel_17.TomRemoteLogServer.localOutput,
    },
    staticSetters: {
      'localOutput': (visitor, value) => 
        $tom_core_kernel_17.TomRemoteLogServer.localOutput = value as $tom_basics_2.TomLogOutput,
    },
    constructorSignatures: {
      '': 'TomRemoteLogServer()',
    },
    methodSignatures: {
      'receive': 'TomRemoteLogResult receive(TomRemoteLogMessage m)',
    },
    staticGetterSignatures: {
      'localOutput': 'TomLogOutput get localOutput',
    },
    staticSetterSignatures: {
      'localOutput': 'set localOutput(dynamic value)',
    },
  );
}

// =============================================================================
// TomTextResourceProvider Bridge
// =============================================================================

BridgedClass _createTomTextResourceProviderBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_21.TomTextResourceProvider,
    name: 'TomTextResourceProvider',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_21.TomTextResourceProvider();
      },
      'load': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomTextResourceProvider');
        if (positional.isEmpty) {
          throw ArgumentError('TomTextResourceProvider: Missing required argument "loader" at position 0');
        }
        final loaderRaw = positional[0];
        return $tom_core_kernel_21.TomTextResourceProvider.load(() { return D4.callInterpreterCallback(visitor, loaderRaw, []) as Map<String, dynamic>; });
      },
      'from': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomTextResourceProvider');
        if (positional.isEmpty) {
          throw ArgumentError('TomTextResourceProvider: Missing required argument "resources" at position 0');
        }
        final resources = D4.coerceMap<String, dynamic>(positional[0], 'resources');
        return $tom_core_kernel_21.TomTextResourceProvider.from(resources);
      },
    },
    getters: {
      'resources': (visitor, target) => D4.validateTarget<$tom_core_kernel_21.TomTextResourceProvider>(target, 'TomTextResourceProvider').resources,
    },
    setters: {
      'resources': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_21.TomTextResourceProvider>(target, 'TomTextResourceProvider').resources = (value as Map).cast<String, dynamic>(),
    },
    methods: {
      'exists': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_21.TomTextResourceProvider>(target, 'TomTextResourceProvider');
        D4.requireMinArgs(positional, 1, 'exists');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'exists');
        return t.exists(s);
      },
      'getText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_21.TomTextResourceProvider>(target, 'TomTextResourceProvider');
        D4.requireMinArgs(positional, 1, 'getText');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'getText');
        return t.getText(s);
      },
    },
    staticGetters: {
      'loader': (visitor) => $tom_core_kernel_21.TomTextResourceProvider.loader,
    },
    staticMethods: {
      'setAppResourceProvider': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setAppResourceProvider');
        final provider = D4.getRequiredArg<$tom_core_kernel_21.TomTextResourceProvider>(positional, 0, 'provider', 'setAppResourceProvider');
        return $tom_core_kernel_21.TomTextResourceProvider.setAppResourceProvider(provider);
      },
      'getAppResources': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_21.TomTextResourceProvider.getAppResources();
      },
    },
    staticSetters: {
      'loader': (visitor, value) => 
        $tom_core_kernel_21.TomTextResourceProvider.loader = value as Map<String, dynamic> Function()?,
    },
    constructorSignatures: {
      '': 'TomTextResourceProvider()',
      'load': 'TomTextResourceProvider.load(Map<String, dynamic> Function() loader)',
      'from': 'TomTextResourceProvider.from(Map<String, dynamic> resources)',
    },
    methodSignatures: {
      'exists': 'bool exists(String s)',
      'getText': 'String getText(String s)',
    },
    getterSignatures: {
      'resources': 'Map<String, dynamic> get resources',
    },
    setterSignatures: {
      'resources': 'set resources(dynamic value)',
    },
    staticMethodSignatures: {
      'setAppResourceProvider': 'void setAppResourceProvider(TomTextResourceProvider provider)',
      'getAppResources': 'TomTextResourceProvider getAppResources()',
    },
    staticGetterSignatures: {
      'loader': 'Map<String, dynamic> Function()? get loader',
    },
    staticSetterSignatures: {
      'loader': 'set loader(dynamic value)',
    },
  );
}

// =============================================================================
// TomConfigResourceProvider Bridge
// =============================================================================

BridgedClass _createTomConfigResourceProviderBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_21.TomConfigResourceProvider,
    name: 'TomConfigResourceProvider',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_21.TomConfigResourceProvider();
      },
      'load': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomConfigResourceProvider');
        if (positional.isEmpty) {
          throw ArgumentError('TomConfigResourceProvider: Missing required argument "loader" at position 0');
        }
        final loaderRaw = positional[0];
        return $tom_core_kernel_21.TomConfigResourceProvider.load(() { return D4.callInterpreterCallback(visitor, loaderRaw, []) as Map<String, dynamic>; });
      },
      'from': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomConfigResourceProvider');
        if (positional.isEmpty) {
          throw ArgumentError('TomConfigResourceProvider: Missing required argument "resources" at position 0');
        }
        final resources = D4.coerceMap<String, dynamic>(positional[0], 'resources');
        return $tom_core_kernel_21.TomConfigResourceProvider.from(resources);
      },
    },
    getters: {
      'resources': (visitor, target) => D4.validateTarget<$tom_core_kernel_21.TomConfigResourceProvider>(target, 'TomConfigResourceProvider').resources,
    },
    setters: {
      'resources': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_21.TomConfigResourceProvider>(target, 'TomConfigResourceProvider').resources = (value as Map).cast<String, dynamic>(),
    },
    methods: {
      'exists': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_21.TomConfigResourceProvider>(target, 'TomConfigResourceProvider');
        D4.requireMinArgs(positional, 1, 'exists');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'exists');
        return t.exists(s);
      },
      'getText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_21.TomConfigResourceProvider>(target, 'TomConfigResourceProvider');
        D4.requireMinArgs(positional, 1, 'getText');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'getText');
        return t.getText(s);
      },
    },
    staticGetters: {
      'loader': (visitor) => $tom_core_kernel_21.TomConfigResourceProvider.loader,
    },
    staticMethods: {
      'setAppConfigProvider': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setAppConfigProvider');
        final provider = D4.getRequiredArg<$tom_core_kernel_21.TomConfigResourceProvider>(positional, 0, 'provider', 'setAppConfigProvider');
        return $tom_core_kernel_21.TomConfigResourceProvider.setAppConfigProvider(provider);
      },
      'getAppConfig': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_21.TomConfigResourceProvider.getAppConfig();
      },
    },
    staticSetters: {
      'loader': (visitor, value) => 
        $tom_core_kernel_21.TomConfigResourceProvider.loader = value as Map<String, dynamic> Function()?,
    },
    constructorSignatures: {
      '': 'TomConfigResourceProvider()',
      'load': 'TomConfigResourceProvider.load(Map<String, dynamic> Function() loader)',
      'from': 'TomConfigResourceProvider.from(Map<String, dynamic> resources)',
    },
    methodSignatures: {
      'exists': 'bool exists(String s)',
      'getText': 'Object getText(String s)',
    },
    getterSignatures: {
      'resources': 'Map<String, dynamic> get resources',
    },
    setterSignatures: {
      'resources': 'set resources(dynamic value)',
    },
    staticMethodSignatures: {
      'setAppConfigProvider': 'void setAppConfigProvider(TomConfigResourceProvider provider)',
      'getAppConfig': 'TomConfigResourceProvider getAppConfig()',
    },
    staticGetterSignatures: {
      'loader': 'Map<String, dynamic> Function()? get loader',
    },
    staticSetterSignatures: {
      'loader': 'set loader(dynamic value)',
    },
  );
}

// =============================================================================
// TomResourceKeyProtection Bridge
// =============================================================================

BridgedClass _createTomResourceKeyProtectionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomResourceKeyProtection,
    name: 'TomResourceKeyProtection',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_22.TomResourceKeyProtection();
      },
    },
    staticGetters: {
      'globalSettingProtectionDefault': (visitor) => $tom_core_kernel_22.TomResourceKeyProtection.globalSettingProtectionDefault,
      'globalSettingUseAutomaticEndpointProtection': (visitor) => $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticEndpointProtection,
      'globalSettingUseAutomaticJsonProtection': (visitor) => $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticJsonProtection,
      'globalSettingUseAutomaticDatabaseProtection': (visitor) => $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticDatabaseProtection,
      'globalSettingUseAutomaticFormFieldProtection': (visitor) => $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticFormFieldProtection,
      'globalSettingUseAutomaticActionProtection': (visitor) => $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticActionProtection,
      'globalSettingUseAutomaticActionProtectionForDisabling': (visitor) => $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticActionProtectionForDisabling,
    },
    staticMethods: {
      'protect': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'protect');
        final data = D4.getRequiredArg<dynamic>(positional, 0, 'data', 'protect');
        final fallback = D4.getRequiredArg<dynamic>(positional, 1, 'fallback', 'protect');
        final resourceKey = D4.getRequiredArg<String>(positional, 2, 'resourceKey', 'protect');
        return $tom_core_kernel_22.TomResourceKeyProtection.protect(data, fallback, resourceKey);
      },
      'isProtected': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isProtected');
        final resourceKey = D4.getRequiredArg<String>(positional, 0, 'resourceKey', 'isProtected');
        return $tom_core_kernel_22.TomResourceKeyProtection.isProtected(resourceKey);
      },
    },
    staticSetters: {
      'globalSettingProtectionDefault': (visitor, value) => 
        $tom_core_kernel_22.TomResourceKeyProtection.globalSettingProtectionDefault = value as bool,
      'globalSettingUseAutomaticEndpointProtection': (visitor, value) => 
        $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticEndpointProtection = value as bool,
      'globalSettingUseAutomaticJsonProtection': (visitor, value) => 
        $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticJsonProtection = value as bool,
      'globalSettingUseAutomaticDatabaseProtection': (visitor, value) => 
        $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticDatabaseProtection = value as bool,
      'globalSettingUseAutomaticFormFieldProtection': (visitor, value) => 
        $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticFormFieldProtection = value as bool,
      'globalSettingUseAutomaticActionProtection': (visitor, value) => 
        $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticActionProtection = value as bool,
      'globalSettingUseAutomaticActionProtectionForDisabling': (visitor, value) => 
        $tom_core_kernel_22.TomResourceKeyProtection.globalSettingUseAutomaticActionProtectionForDisabling = value as bool,
    },
    constructorSignatures: {
      '': 'TomResourceKeyProtection()',
    },
    staticMethodSignatures: {
      'protect': 'T protect(T data, T fallback, String resourceKey)',
      'isProtected': 'bool isProtected(String resourceKey)',
    },
    staticGetterSignatures: {
      'globalSettingProtectionDefault': 'bool get globalSettingProtectionDefault',
      'globalSettingUseAutomaticEndpointProtection': 'bool get globalSettingUseAutomaticEndpointProtection',
      'globalSettingUseAutomaticJsonProtection': 'bool get globalSettingUseAutomaticJsonProtection',
      'globalSettingUseAutomaticDatabaseProtection': 'bool get globalSettingUseAutomaticDatabaseProtection',
      'globalSettingUseAutomaticFormFieldProtection': 'bool get globalSettingUseAutomaticFormFieldProtection',
      'globalSettingUseAutomaticActionProtection': 'bool get globalSettingUseAutomaticActionProtection',
      'globalSettingUseAutomaticActionProtectionForDisabling': 'bool get globalSettingUseAutomaticActionProtectionForDisabling',
    },
    staticSetterSignatures: {
      'globalSettingProtectionDefault': 'set globalSettingProtectionDefault(dynamic value)',
      'globalSettingUseAutomaticEndpointProtection': 'set globalSettingUseAutomaticEndpointProtection(dynamic value)',
      'globalSettingUseAutomaticJsonProtection': 'set globalSettingUseAutomaticJsonProtection(dynamic value)',
      'globalSettingUseAutomaticDatabaseProtection': 'set globalSettingUseAutomaticDatabaseProtection(dynamic value)',
      'globalSettingUseAutomaticFormFieldProtection': 'set globalSettingUseAutomaticFormFieldProtection(dynamic value)',
      'globalSettingUseAutomaticActionProtection': 'set globalSettingUseAutomaticActionProtection(dynamic value)',
      'globalSettingUseAutomaticActionProtectionForDisabling': 'set globalSettingUseAutomaticActionProtectionForDisabling(dynamic value)',
    },
  );
}

// =============================================================================
// TomAccessControl Bridge
// =============================================================================

BridgedClass _createTomAccessControlBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomAccessControl,
    name: 'TomAccessControl',
    constructors: {
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomAccessControl>(target, 'TomAccessControl');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
    },
  );
}

// =============================================================================
// TomNoAccess Bridge
// =============================================================================

BridgedClass _createTomNoAccessBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomNoAccess,
    name: 'TomNoAccess',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_22.TomNoAccess();
      },
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomNoAccess>(target, 'TomNoAccess');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
    },
    constructorSignatures: {
      '': 'const TomNoAccess()',
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
    },
  );
}

// =============================================================================
// TomPublicAccess Bridge
// =============================================================================

BridgedClass _createTomPublicAccessBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomPublicAccess,
    name: 'TomPublicAccess',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_22.TomPublicAccess();
      },
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomPublicAccess>(target, 'TomPublicAccess');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
    },
    constructorSignatures: {
      '': 'const TomPublicAccess()',
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
    },
  );
}

// =============================================================================
// TomAuthenticatedAccess Bridge
// =============================================================================

BridgedClass _createTomAuthenticatedAccessBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomAuthenticatedAccess,
    name: 'TomAuthenticatedAccess',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_22.TomAuthenticatedAccess();
      },
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomAuthenticatedAccess>(target, 'TomAuthenticatedAccess');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
    },
    constructorSignatures: {
      '': 'const TomAuthenticatedAccess()',
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
    },
  );
}

// =============================================================================
// TomGuestAccess Bridge
// =============================================================================

BridgedClass _createTomGuestAccessBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomGuestAccess,
    name: 'TomGuestAccess',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_22.TomGuestAccess();
      },
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomGuestAccess>(target, 'TomGuestAccess');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
    },
    constructorSignatures: {
      '': 'const TomGuestAccess()',
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
    },
  );
}

// =============================================================================
// TomCustomAccess Bridge
// =============================================================================

BridgedClass _createTomCustomAccessBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomCustomAccess,
    name: 'TomCustomAccess',
    constructors: {
      '': (visitor, positional, named) {
        final handler = D4.getRequiredNamedArg<String>(named, 'handler', 'TomCustomAccess');
        final resourceId = D4.getRequiredNamedArg<String>(named, 'resourceId', 'TomCustomAccess');
        return $tom_core_kernel_22.TomCustomAccess(handler: handler, resourceId: resourceId);
      },
    },
    getters: {
      'handler': (visitor, target) => D4.validateTarget<$tom_core_kernel_22.TomCustomAccess>(target, 'TomCustomAccess').handler,
      'resourceId': (visitor, target) => D4.validateTarget<$tom_core_kernel_22.TomCustomAccess>(target, 'TomCustomAccess').resourceId,
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomCustomAccess>(target, 'TomCustomAccess');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
      'verifyHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomCustomAccess>(target, 'TomCustomAccess');
        return t.verifyHandler();
      },
    },
    staticMethods: {
      'registerHandler': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'registerHandler');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'registerHandler');
        if (positional.length <= 1) {
          throw ArgumentError('registerHandler: Missing required argument "handler" at position 1');
        }
        final handlerRaw = positional[1];
        final handler = ($tom_core_kernel_25.TomPrincipal? p0, String p1) { return D4.callInterpreterCallback(visitor, handlerRaw, [p0, p1]) as bool; };
        return $tom_core_kernel_22.TomCustomAccess.registerHandler(name, handler);
      },
      'getHandler': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getHandler');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getHandler');
        return $tom_core_kernel_22.TomCustomAccess.getHandler(name);
      },
      'handlerExists': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'handlerExists');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'handlerExists');
        return $tom_core_kernel_22.TomCustomAccess.handlerExists(name);
      },
    },
    constructorSignatures: {
      '': 'const TomCustomAccess({required String handler, required String resourceId})',
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
      'verifyHandler': 'bool verifyHandler()',
    },
    getterSignatures: {
      'handler': 'String get handler',
      'resourceId': 'String get resourceId',
    },
    staticMethodSignatures: {
      'registerHandler': 'void registerHandler(String name, TomAccessControlHandler handler)',
      'getHandler': 'TomAccessControlHandler getHandler(String name)',
      'handlerExists': 'bool handlerExists(String name)',
    },
  );
}

// =============================================================================
// TomEntitlementAccess Bridge
// =============================================================================

BridgedClass _createTomEntitlementAccessBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomEntitlementAccess,
    name: 'TomEntitlementAccess',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomEntitlementAccess');
        if (positional.isEmpty) {
          throw ArgumentError('TomEntitlementAccess: Missing required argument "patterns" at position 0');
        }
        final patterns = D4.coerceList<String>(positional[0], 'patterns');
        return $tom_core_kernel_22.TomEntitlementAccess(patterns);
      },
    },
    getters: {
      'patterns': (visitor, target) => D4.validateTarget<$tom_core_kernel_22.TomEntitlementAccess>(target, 'TomEntitlementAccess').patterns,
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomEntitlementAccess>(target, 'TomEntitlementAccess');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
    },
    constructorSignatures: {
      '': 'const TomEntitlementAccess(List<String> patterns)',
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
    },
    getterSignatures: {
      'patterns': 'List<String> get patterns',
    },
  );
}

// =============================================================================
// TomRoleAccess Bridge
// =============================================================================

BridgedClass _createTomRoleAccessBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomRoleAccess,
    name: 'TomRoleAccess',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomRoleAccess');
        if (positional.isEmpty) {
          throw ArgumentError('TomRoleAccess: Missing required argument "roles" at position 0');
        }
        final roles = D4.coerceList<String>(positional[0], 'roles');
        return $tom_core_kernel_22.TomRoleAccess(roles);
      },
    },
    getters: {
      'roles': (visitor, target) => D4.validateTarget<$tom_core_kernel_22.TomRoleAccess>(target, 'TomRoleAccess').roles,
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomRoleAccess>(target, 'TomRoleAccess');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
    },
    constructorSignatures: {
      '': 'const TomRoleAccess(List<String> roles)',
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
    },
    getterSignatures: {
      'roles': 'List<String> get roles',
    },
  );
}

// =============================================================================
// TomGroupAccess Bridge
// =============================================================================

BridgedClass _createTomGroupAccessBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomGroupAccess,
    name: 'TomGroupAccess',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomGroupAccess');
        if (positional.isEmpty) {
          throw ArgumentError('TomGroupAccess: Missing required argument "groups" at position 0');
        }
        final groups = D4.coerceList<String>(positional[0], 'groups');
        return $tom_core_kernel_22.TomGroupAccess(groups);
      },
    },
    getters: {
      'groups': (visitor, target) => D4.validateTarget<$tom_core_kernel_22.TomGroupAccess>(target, 'TomGroupAccess').groups,
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomGroupAccess>(target, 'TomGroupAccess');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
    },
    constructorSignatures: {
      '': 'const TomGroupAccess(List<String> groups)',
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
    },
    getterSignatures: {
      'groups': 'List<String> get groups',
    },
  );
}

// =============================================================================
// TomResourceKeyAccess Bridge
// =============================================================================

BridgedClass _createTomResourceKeyAccessBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_22.TomResourceKeyAccess,
    name: 'TomResourceKeyAccess',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomResourceKeyAccess');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomResourceKeyAccess');
        return $tom_core_kernel_22.TomResourceKeyAccess(key);
      },
    },
    getters: {
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_22.TomResourceKeyAccess>(target, 'TomResourceKeyAccess').key,
    },
    methods: {
      'checkAccessibility': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_22.TomResourceKeyAccess>(target, 'TomResourceKeyAccess');
        D4.requireMinArgs(positional, 1, 'checkAccessibility');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal?>(positional, 0, 'principal', 'checkAccessibility');
        return t.checkAccessibility(principal);
      },
    },
    constructorSignatures: {
      '': 'const TomResourceKeyAccess(String key)',
    },
    methodSignatures: {
      'checkAccessibility': 'bool checkAccessibility(TomPrincipal? principal)',
    },
    getterSignatures: {
      'key': 'String get key',
    },
  );
}

// =============================================================================
// TomAuthenticationMessage Bridge
// =============================================================================

BridgedClass _createTomAuthenticationMessageBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_23.TomAuthenticationMessage,
    name: 'TomAuthenticationMessage',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_23.TomAuthenticationMessage();
      },
    },
    getters: {
      'client': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').client,
      'userName': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').userName,
      'password': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').password,
      'application': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').application,
      'process': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').process,
      'organization': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').organization,
      'clientLanguage': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').clientLanguage,
      'clientCountry': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').clientCountry,
      'clientTimezone': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').clientTimezone,
    },
    setters: {
      'client': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').client = value as String,
      'userName': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').userName = value as String,
      'password': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').password = value as String,
      'application': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').application = value as String,
      'process': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').process = value as String,
      'organization': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').organization = value as String,
      'clientLanguage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').clientLanguage = value as String,
      'clientCountry': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').clientCountry = value as String,
      'clientTimezone': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationMessage>(target, 'TomAuthenticationMessage').clientTimezone = value as String,
    },
    constructorSignatures: {
      '': 'TomAuthenticationMessage()',
    },
    getterSignatures: {
      'client': 'String get client',
      'userName': 'String get userName',
      'password': 'String get password',
      'application': 'String get application',
      'process': 'String get process',
      'organization': 'String get organization',
      'clientLanguage': 'String get clientLanguage',
      'clientCountry': 'String get clientCountry',
      'clientTimezone': 'String get clientTimezone',
    },
    setterSignatures: {
      'client': 'set client(dynamic value)',
      'userName': 'set userName(dynamic value)',
      'password': 'set password(dynamic value)',
      'application': 'set application(dynamic value)',
      'process': 'set process(dynamic value)',
      'organization': 'set organization(dynamic value)',
      'clientLanguage': 'set clientLanguage(dynamic value)',
      'clientCountry': 'set clientCountry(dynamic value)',
      'clientTimezone': 'set clientTimezone(dynamic value)',
    },
  );
}

// =============================================================================
// TomAuthenticationResult Bridge
// =============================================================================

BridgedClass _createTomAuthenticationResultBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_23.TomAuthenticationResult,
    name: 'TomAuthenticationResult',
    constructors: {
      '': (visitor, positional, named) {
        final error = D4.getOptionalArgWithDefault<String>(positional, 0, 'error', "");
        return $tom_core_kernel_23.TomAuthenticationResult(error);
      },
    },
    getters: {
      'error': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').error,
      'authenticationToken': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').authenticationToken,
      'authorizationToken': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').authorizationToken,
      'requires2FA': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').requires2FA,
      'twoFactorType': (visitor, target) => D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').twoFactorType,
    },
    setters: {
      'error': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').error = value as String,
      'authenticationToken': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').authenticationToken = value as String,
      'authorizationToken': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').authorizationToken = value as String,
      'requires2FA': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').requires2FA = value as bool,
      'twoFactorType': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_23.TomAuthenticationResult>(target, 'TomAuthenticationResult').twoFactorType = value as String,
    },
    constructorSignatures: {
      '': 'TomAuthenticationResult([String error = ""])',
    },
    getterSignatures: {
      'error': 'String get error',
      'authenticationToken': 'String get authenticationToken',
      'authorizationToken': 'String get authorizationToken',
      'requires2FA': 'bool get requires2FA',
      'twoFactorType': 'String get twoFactorType',
    },
    setterSignatures: {
      'error': 'set error(dynamic value)',
      'authenticationToken': 'set authenticationToken(dynamic value)',
      'authorizationToken': 'set authorizationToken(dynamic value)',
      'requires2FA': 'set requires2FA(dynamic value)',
      'twoFactorType': 'set twoFactorType(dynamic value)',
    },
  );
}

// =============================================================================
// TomBearerAuthentication Bridge
// =============================================================================

BridgedClass _createTomBearerAuthenticationBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_24.TomBearerAuthentication,
    name: 'TomBearerAuthentication',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_24.TomBearerAuthentication();
      },
    },
    staticGetters: {
      'bearerAuthentication': (visitor) => $tom_core_kernel_24.TomBearerAuthentication.bearerAuthentication,
      'token': (visitor) => $tom_core_kernel_24.TomBearerAuthentication.token,
      'authorizationToken': (visitor) => $tom_core_kernel_24.TomBearerAuthentication.authorizationToken,
      'clientJwtToken': (visitor) => $tom_core_kernel_24.TomBearerAuthentication.clientJwtToken,
      'clientAuthorizationJwtToken': (visitor) => $tom_core_kernel_24.TomBearerAuthentication.clientAuthorizationJwtToken,
    },
    staticMethods: {
      'setTokens': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'setTokens');
        final authenticationToken = D4.getRequiredArg<String>(positional, 0, 'authenticationToken', 'setTokens');
        final authorizationToken = D4.getRequiredArg<String>(positional, 1, 'authorizationToken', 'setTokens');
        final decrypt = D4.getOptionalArgWithDefault<bool>(positional, 2, 'decrypt', true);
        return $tom_core_kernel_24.TomBearerAuthentication.setTokens(authenticationToken, authorizationToken, decrypt);
      },
      'convertTokenPayloadToPrincipal': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'convertTokenPayloadToPrincipal');
        final authenticationToken = D4.getRequiredArg<$tom_crypto_1.TomClientJwtToken>(positional, 0, 'authenticationToken', 'convertTokenPayloadToPrincipal');
        final authorizationToken = D4.getOptionalArg<$tom_crypto_1.TomClientJwtToken?>(positional, 1, 'authorizationToken');
        return $tom_core_kernel_24.TomBearerAuthentication.convertTokenPayloadToPrincipal(authenticationToken, authorizationToken);
      },
      'getPrincipal': (visitor, positional, named, typeArgs) {
        return $tom_core_kernel_24.TomBearerAuthentication.getPrincipal();
      },
      'updatePrincipal': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'updatePrincipal');
        if (positional.isEmpty) {
          throw ArgumentError('updatePrincipal: Missing required argument "groups" at position 0');
        }
        final groups = D4.coerceList<String>(positional[0], 'groups');
        if (positional.length <= 1) {
          throw ArgumentError('updatePrincipal: Missing required argument "roles" at position 1');
        }
        final roles = D4.coerceList<String>(positional[1], 'roles');
        if (positional.length <= 2) {
          throw ArgumentError('updatePrincipal: Missing required argument "entitlements" at position 2');
        }
        final entitlements = D4.coerceList<String>(positional[2], 'entitlements');
        if (positional.length <= 3) {
          throw ArgumentError('updatePrincipal: Missing required argument "resourceKeys" at position 3');
        }
        final resourceKeys = D4.coerceList<String>(positional[3], 'resourceKeys');
        return $tom_core_kernel_24.TomBearerAuthentication.updatePrincipal(groups, roles, entitlements, resourceKeys);
      },
      'convertPrincipalToTokenPayload': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'convertPrincipalToTokenPayload');
        final principal = D4.getRequiredArg<$tom_core_kernel_25.TomPrincipal>(positional, 0, 'principal', 'convertPrincipalToTokenPayload');
        final definition = D4.getRequiredArg<$tom_core_kernel_25.TomAccessControlDefinition?>(positional, 1, 'definition', 'convertPrincipalToTokenPayload');
        final clientCountry = D4.getRequiredArg<String?>(positional, 2, 'clientCountry', 'convertPrincipalToTokenPayload');
        final clientLanguage = D4.getRequiredArg<String?>(positional, 3, 'clientLanguage', 'convertPrincipalToTokenPayload');
        return $tom_core_kernel_24.TomBearerAuthentication.convertPrincipalToTokenPayload(principal, definition, clientCountry, clientLanguage);
      },
    },
    staticSetters: {
      'bearerAuthentication': (visitor, value) => 
        $tom_core_kernel_24.TomBearerAuthentication.bearerAuthentication = value as $tom_core_kernel_24.TomBearerAuthentication,
    },
    constructorSignatures: {
      '': 'TomBearerAuthentication()',
    },
    staticMethodSignatures: {
      'setTokens': 'void setTokens(String authenticationToken, String authorizationToken, [bool decrypt = true])',
      'convertTokenPayloadToPrincipal': 'TomPrincipal convertTokenPayloadToPrincipal(TomClientJwtToken authenticationToken, [TomClientJwtToken? authorizationToken])',
      'getPrincipal': 'TomPrincipal getPrincipal()',
      'updatePrincipal': 'void updatePrincipal(List<String> groups, List<String> roles, List<String> entitlements, List<String> resourceKeys)',
      'convertPrincipalToTokenPayload': '(Map<String, Object?>, Map<String, Object?>) convertPrincipalToTokenPayload(TomPrincipal principal, TomAccessControlDefinition? definition, String? clientCountry, String? clientLanguage)',
    },
    staticGetterSignatures: {
      'bearerAuthentication': 'TomBearerAuthentication get bearerAuthentication',
      'token': 'String? get token',
      'authorizationToken': 'String? get authorizationToken',
      'clientJwtToken': 'TomClientJwtToken? get clientJwtToken',
      'clientAuthorizationJwtToken': 'TomClientJwtToken? get clientAuthorizationJwtToken',
    },
    staticSetterSignatures: {
      'bearerAuthentication': 'set bearerAuthentication(dynamic value)',
    },
  );
}

// =============================================================================
// TomAccessControlInformation Bridge
// =============================================================================

BridgedClass _createTomAccessControlInformationBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_25.TomAccessControlInformation,
    name: 'TomAccessControlInformation',
    constructors: {
      '': (visitor, positional, named) {
        final roles = named.containsKey('roles') && named['roles'] != null
            ? D4.coerceList<String>(named['roles'], 'roles')
            : const <String>[];
        final entitlements = named.containsKey('entitlements') && named['entitlements'] != null
            ? D4.coerceList<String>(named['entitlements'], 'entitlements')
            : const <String>[];
        final resourceKeys = named.containsKey('resourceKeys') && named['resourceKeys'] != null
            ? D4.coerceList<String>(named['resourceKeys'], 'resourceKeys')
            : const <String>[];
        final groups = named.containsKey('groups') && named['groups'] != null
            ? D4.coerceList<String>(named['groups'], 'groups')
            : const <String>[];
        return $tom_core_kernel_25.TomAccessControlInformation(roles: roles, entitlements: entitlements, resourceKeys: resourceKeys, groups: groups);
      },
    },
    getters: {
      'roles': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomAccessControlInformation>(target, 'TomAccessControlInformation').roles,
      'groups': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomAccessControlInformation>(target, 'TomAccessControlInformation').groups,
      'entitlements': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomAccessControlInformation>(target, 'TomAccessControlInformation').entitlements,
      'resourceKeys': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomAccessControlInformation>(target, 'TomAccessControlInformation').resourceKeys,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomAccessControlInformation>(target, 'TomAccessControlInformation');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TomAccessControlInformation({List<String> roles = const [], List<String> entitlements = const [], List<String> resourceKeys = const [], List<String> groups = const []})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'roles': 'List<String> get roles',
      'groups': 'List<String> get groups',
      'entitlements': 'List<String> get entitlements',
      'resourceKeys': 'List<String> get resourceKeys',
    },
  );
}

// =============================================================================
// TomClientLimitsInformation Bridge
// =============================================================================

BridgedClass _createTomClientLimitsInformationBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_25.TomClientLimitsInformation,
    name: 'TomClientLimitsInformation',
    constructors: {
      '': (visitor, positional, named) {
        final enabledModules = named.containsKey('enabledModules') && named['enabledModules'] != null
            ? D4.coerceList<String>(named['enabledModules'], 'enabledModules')
            : const <String>[];
        final quotas = named.containsKey('quotas') && named['quotas'] != null
            ? D4.coerceMap<String, int>(named['quotas'], 'quotas')
            : const <String, int>{};
        return $tom_core_kernel_25.TomClientLimitsInformation(enabledModules: enabledModules, quotas: quotas);
      },
    },
    getters: {
      'enabledModules': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomClientLimitsInformation>(target, 'TomClientLimitsInformation').enabledModules,
      'quotas': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomClientLimitsInformation>(target, 'TomClientLimitsInformation').quotas,
    },
    setters: {
      'enabledModules': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomClientLimitsInformation>(target, 'TomClientLimitsInformation').enabledModules = (value as List).cast<String>().toList(),
      'quotas': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomClientLimitsInformation>(target, 'TomClientLimitsInformation').quotas = (value as Map).cast<String, int>(),
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomClientLimitsInformation>(target, 'TomClientLimitsInformation');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TomClientLimitsInformation({List<String> enabledModules = const [], Map<String, int> quotas = const {}})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'enabledModules': 'List<String> get enabledModules',
      'quotas': 'Map<String, int> get quotas',
    },
    setterSignatures: {
      'enabledModules': 'set enabledModules(dynamic value)',
      'quotas': 'set quotas(dynamic value)',
    },
  );
}

// =============================================================================
// TomAccessControlDefinition Bridge
// =============================================================================

BridgedClass _createTomAccessControlDefinitionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_25.TomAccessControlDefinition,
    name: 'TomAccessControlDefinition',
    constructors: {
      '': (visitor, positional, named) {
        final roles = D4.coerceListOrNull<$tom_core_kernel_25.TomRole>(named['roles'], 'roles');
        final groups = D4.coerceListOrNull<$tom_core_kernel_25.TomGroup>(named['groups'], 'groups');
        final entitlements = D4.coerceListOrNull<$tom_core_kernel_25.TomEntitlement>(named['entitlements'], 'entitlements');
        return $tom_core_kernel_25.TomAccessControlDefinition(roles: roles, groups: groups, entitlements: entitlements);
      },
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomAccessControlDefinition>(target, 'TomAccessControlDefinition');
        return t.toString();
      },
      'completeFromDefinition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomAccessControlDefinition>(target, 'TomAccessControlDefinition');
        D4.requireMinArgs(positional, 1, 'completeFromDefinition');
        final userProvided = D4.getRequiredArg<$tom_core_kernel_25.TomAccessControlInformation>(positional, 0, 'userProvided', 'completeFromDefinition');
        return t.completeFromDefinition(userProvided);
      },
    },
    constructorSignatures: {
      '': 'TomAccessControlDefinition({List<TomRole>? roles, List<TomGroup>? groups, List<TomEntitlement>? entitlements})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'completeFromDefinition': 'TomAccessControlInformation completeFromDefinition(TomAccessControlInformation userProvided)',
    },
  );
}

// =============================================================================
// TomGroup Bridge
// =============================================================================

BridgedClass _createTomGroupBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_25.TomGroup,
    name: 'TomGroup',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'TomGroup');
        final rolesIncluded = D4.coerceListOrNull<String>(named['rolesIncluded'], 'rolesIncluded');
        final groupMemberShips = D4.coerceListOrNull<String>(named['groupMemberShips'], 'groupMemberShips');
        final entitlements = D4.coerceListOrNull<String>(named['entitlements'], 'entitlements');
        final resourceKeys = D4.coerceListOrNull<String>(named['resourceKeys'], 'resourceKeys');
        return $tom_core_kernel_25.TomGroup(name: name, rolesIncluded: rolesIncluded, groupMemberShips: groupMemberShips, entitlements: entitlements, resourceKeys: resourceKeys);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomGroup>(target, 'TomGroup').name,
      'rolesIncluded': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomGroup>(target, 'TomGroup').rolesIncluded,
      'groupMemberShips': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomGroup>(target, 'TomGroup').groupMemberShips,
      'entitlements': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomGroup>(target, 'TomGroup').entitlements,
      'resourceKeys': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomGroup>(target, 'TomGroup').resourceKeys,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomGroup>(target, 'TomGroup');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TomGroup({required String name, List<String>? rolesIncluded, List<String>? groupMemberShips, List<String>? entitlements, List<String>? resourceKeys})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'rolesIncluded': 'List<String> get rolesIncluded',
      'groupMemberShips': 'List<String> get groupMemberShips',
      'entitlements': 'List<String> get entitlements',
      'resourceKeys': 'List<String> get resourceKeys',
    },
  );
}

// =============================================================================
// TomRole Bridge
// =============================================================================

BridgedClass _createTomRoleBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_25.TomRole,
    name: 'TomRole',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'TomRole');
        final rolesIncluded = D4.coerceListOrNull<String>(named['rolesIncluded'], 'rolesIncluded');
        final groupMemberShips = D4.coerceListOrNull<String>(named['groupMemberShips'], 'groupMemberShips');
        final entitlements = D4.coerceListOrNull<String>(named['entitlements'], 'entitlements');
        final resourceKeys = D4.coerceListOrNull<String>(named['resourceKeys'], 'resourceKeys');
        return $tom_core_kernel_25.TomRole(name: name, rolesIncluded: rolesIncluded, groupMemberShips: groupMemberShips, entitlements: entitlements, resourceKeys: resourceKeys);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomRole>(target, 'TomRole').name,
      'rolesIncluded': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomRole>(target, 'TomRole').rolesIncluded,
      'groupMemberShips': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomRole>(target, 'TomRole').groupMemberShips,
      'entitlements': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomRole>(target, 'TomRole').entitlements,
      'resourceKeys': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomRole>(target, 'TomRole').resourceKeys,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomRole>(target, 'TomRole');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TomRole({required String name, List<String>? rolesIncluded, List<String>? groupMemberShips, List<String>? entitlements, List<String>? resourceKeys})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'rolesIncluded': 'List<String> get rolesIncluded',
      'groupMemberShips': 'List<String> get groupMemberShips',
      'entitlements': 'List<String> get entitlements',
      'resourceKeys': 'List<String> get resourceKeys',
    },
  );
}

// =============================================================================
// TomEntitlement Bridge
// =============================================================================

BridgedClass _createTomEntitlementBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_25.TomEntitlement,
    name: 'TomEntitlement',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'TomEntitlement');
        final entitlements = D4.coerceListOrNull<String>(named['entitlements'], 'entitlements');
        final resourceKeys = D4.coerceListOrNull<String>(named['resourceKeys'], 'resourceKeys');
        return $tom_core_kernel_25.TomEntitlement(name: name, entitlements: entitlements, resourceKeys: resourceKeys);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomEntitlement>(target, 'TomEntitlement').name,
      'entitlements': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomEntitlement>(target, 'TomEntitlement').entitlements,
      'resourceKeys': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomEntitlement>(target, 'TomEntitlement').resourceKeys,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomEntitlement>(target, 'TomEntitlement');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TomEntitlement({required String name, List<String>? entitlements, List<String>? resourceKeys})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'entitlements': 'List<String> get entitlements',
      'resourceKeys': 'List<String> get resourceKeys',
    },
  );
}

// =============================================================================
// TomUser Bridge
// =============================================================================

BridgedClass _createTomUserBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_25.TomUser,
    name: 'TomUser',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getNamedArgWithDefault<int>(named, 'id', -1);
        final firstname = D4.getOptionalNamedArg<String?>(named, 'firstname');
        final lastname = D4.getOptionalNamedArg<String?>(named, 'lastname');
        final email = D4.getOptionalNamedArg<String?>(named, 'email');
        final phone = D4.getOptionalNamedArg<String?>(named, 'phone');
        final mobile = D4.getOptionalNamedArg<String?>(named, 'mobile');
        final addressLine1 = D4.getOptionalNamedArg<String?>(named, 'addressLine1');
        final addressLine2 = D4.getOptionalNamedArg<String?>(named, 'addressLine2');
        final city = D4.getOptionalNamedArg<String?>(named, 'city');
        final postcode = D4.getOptionalNamedArg<String?>(named, 'postcode');
        final stateRegion = D4.getOptionalNamedArg<String?>(named, 'stateRegion');
        final timeZone = D4.getOptionalNamedArg<String?>(named, 'timeZone');
        final attributes = D4.coerceMapOrNull<String, Object?>(named['attributes'], 'attributes');
        if (!named.containsKey('username')) {
          return $tom_core_kernel_25.TomUser(id: id, firstname: firstname, lastname: lastname, email: email, phone: phone, mobile: mobile, addressLine1: addressLine1, addressLine2: addressLine2, city: city, postcode: postcode, stateRegion: stateRegion, timeZone: timeZone, attributes: attributes);
        }
        if (named.containsKey('username')) {
          final username = D4.getRequiredNamedArg<String>(named, 'username', 'TomUser');
          return $tom_core_kernel_25.TomUser(id: id, firstname: firstname, lastname: lastname, email: email, phone: phone, mobile: mobile, addressLine1: addressLine1, addressLine2: addressLine2, city: city, postcode: postcode, stateRegion: stateRegion, timeZone: timeZone, attributes: attributes, username: username);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').id,
      'username': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').username,
      'firstname': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').firstname,
      'lastname': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').lastname,
      'email': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').email,
      'phone': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').phone,
      'mobile': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').mobile,
      'addressLine1': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').addressLine1,
      'addressLine2': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').addressLine2,
      'city': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').city,
      'postcode': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').postcode,
      'stateRegion': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').stateRegion,
      'timeZone': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').timeZone,
      'attributes': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser').attributes,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomUser>(target, 'TomUser');
        return t.toString();
      },
    },
    staticGetters: {
      'guestUsername': (visitor) => $tom_core_kernel_25.TomUser.guestUsername,
    },
    constructorSignatures: {
      '': 'TomUser({int id = -1, String username = guestUsername, String? firstname, String? lastname, String? email, String? phone, String? mobile, String? addressLine1, String? addressLine2, String? city, String? postcode, String? stateRegion, String? timeZone, Map<String, Object?>? attributes})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'int get id',
      'username': 'String get username',
      'firstname': 'String? get firstname',
      'lastname': 'String? get lastname',
      'email': 'String? get email',
      'phone': 'String? get phone',
      'mobile': 'String? get mobile',
      'addressLine1': 'String? get addressLine1',
      'addressLine2': 'String? get addressLine2',
      'city': 'String? get city',
      'postcode': 'String? get postcode',
      'stateRegion': 'String? get stateRegion',
      'timeZone': 'String? get timeZone',
      'attributes': 'Map<String, Object?> get attributes',
    },
    staticGetterSignatures: {
      'guestUsername': 'String get guestUsername',
    },
  );
}

// =============================================================================
// TomPrincipal Bridge
// =============================================================================

BridgedClass _createTomPrincipalBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_25.TomPrincipal,
    name: 'TomPrincipal',
    constructors: {
      '': (visitor, positional, named) {
        final cli = D4.getOptionalNamedArg<$tom_core_kernel_25.TomClientLimitsInformation?>(named, 'cli');
        final aci = D4.getOptionalNamedArg<$tom_core_kernel_25.TomAccessControlInformation?>(named, 'aci');
        final user = D4.getOptionalNamedArg<$tom_core_kernel_25.TomUser?>(named, 'user');
        final authenticated = D4.getNamedArgWithDefault<bool>(named, 'authenticated', false);
        final requires2FA = D4.getNamedArgWithDefault<bool>(named, 'requires2FA', false);
        final twoFactorType = D4.getOptionalNamedArg<String?>(named, 'twoFactorType');
        final context = named.containsKey('context') && named['context'] != null
            ? D4.coerceMap<String, Object?>(named['context'], 'context')
            : const <String, Object?>{};
        final organization = D4.getOptionalNamedArg<String?>(named, 'organization');
        final application = D4.getOptionalNamedArg<String?>(named, 'application');
        final process = D4.getOptionalNamedArg<String?>(named, 'process');
        final language = D4.getOptionalNamedArg<String?>(named, 'language');
        final country = D4.getOptionalNamedArg<String?>(named, 'country');
        final clientCountry = D4.getOptionalNamedArg<String?>(named, 'clientCountry');
        final clientLanguage = D4.getOptionalNamedArg<String?>(named, 'clientLanguage');
        final timezone = D4.getOptionalNamedArg<String?>(named, 'timezone');
        final clientTimezone = D4.getOptionalNamedArg<String?>(named, 'clientTimezone');
        final organizationId = D4.getNamedArgWithDefault<int>(named, 'organizationId', -1);
        final applicationId = D4.getNamedArgWithDefault<int>(named, 'applicationId', -1);
        final processId = D4.getNamedArgWithDefault<int>(named, 'processId', -1);
        final clientId = D4.getNamedArgWithDefault<int>(named, 'clientId', -1);
        return $tom_core_kernel_25.TomPrincipal(cli: cli, aci: aci, user: user, authenticated: authenticated, requires2FA: requires2FA, twoFactorType: twoFactorType, context: context, organization: organization, application: application, process: process, language: language, country: country, clientCountry: clientCountry, clientLanguage: clientLanguage, timezone: timezone, clientTimezone: clientTimezone, organizationId: organizationId, applicationId: applicationId, processId: processId, clientId: clientId);
      },
    },
    getters: {
      'authenticated': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').authenticated,
      'id': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').id,
      'username': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').username,
      'user': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').user,
      'organization': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').organization,
      'application': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').application,
      'process': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').process,
      'organizationId': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').organizationId,
      'applicationId': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').applicationId,
      'processId': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').processId,
      'clientId': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').clientId,
      'language': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').language,
      'country': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').country,
      'timezone': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').timezone,
      'clientLanguage': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').clientLanguage,
      'clientCountry': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').clientCountry,
      'clientTimezone': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').clientTimezone,
      'currentContext': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').currentContext,
      'requires2FA': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').requires2FA,
      'twoFactorType': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').twoFactorType,
      'aci': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').aci,
      'cli': (visitor, target) => D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').cli,
    },
    setters: {
      'organization': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').organization = value as String?,
      'application': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').application = value as String?,
      'process': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').process = value as String?,
      'organizationId': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').organizationId = value as int,
      'applicationId': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').applicationId = value as int,
      'processId': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').processId = value as int,
      'clientId': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').clientId = value as int,
      'language': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').language = value as String?,
      'country': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').country = value as String?,
      'timezone': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').timezone = value as String?,
      'clientLanguage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').clientLanguage = value as String?,
      'clientCountry': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').clientCountry = value as String?,
      'clientTimezone': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').clientTimezone = value as String?,
      'aci': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal').aci = value as $tom_core_kernel_25.TomAccessControlInformation,
    },
    methods: {
      'addToContext': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal');
        D4.requireMinArgs(positional, 1, 'addToContext');
        if (positional.isEmpty) {
          throw ArgumentError('addToContext: Missing required argument "attributes" at position 0');
        }
        final attributes = D4.coerceMap<String, Object?>(positional[0], 'attributes');
        t.addToContext(attributes);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_25.TomPrincipal>(target, 'TomPrincipal');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TomPrincipal({TomClientLimitsInformation? cli, TomAccessControlInformation? aci, TomUser? user, bool authenticated = false, bool requires2FA = false, String? twoFactorType, Map<String, Object?> context = const {}, String? organization, String? application, String? process, String? language, String? country, String? clientCountry, String? clientLanguage, String? timezone, String? clientTimezone, int organizationId = -1, int applicationId = -1, int processId = -1, int clientId = -1})',
    },
    methodSignatures: {
      'addToContext': 'void addToContext(Map<String, Object?> attributes)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'authenticated': 'bool get authenticated',
      'id': 'int get id',
      'username': 'String get username',
      'user': 'TomUser get user',
      'organization': 'String? get organization',
      'application': 'String? get application',
      'process': 'String? get process',
      'organizationId': 'int get organizationId',
      'applicationId': 'int get applicationId',
      'processId': 'int get processId',
      'clientId': 'int get clientId',
      'language': 'String? get language',
      'country': 'String? get country',
      'timezone': 'String? get timezone',
      'clientLanguage': 'String? get clientLanguage',
      'clientCountry': 'String? get clientCountry',
      'clientTimezone': 'String? get clientTimezone',
      'currentContext': 'Map<String, Object?> get currentContext',
      'requires2FA': 'bool get requires2FA',
      'twoFactorType': 'String? get twoFactorType',
      'aci': 'TomAccessControlInformation get aci',
      'cli': 'TomClientLimitsInformation get cli',
    },
    setterSignatures: {
      'organization': 'set organization(dynamic value)',
      'application': 'set application(dynamic value)',
      'process': 'set process(dynamic value)',
      'organizationId': 'set organizationId(dynamic value)',
      'applicationId': 'set applicationId(dynamic value)',
      'processId': 'set processId(dynamic value)',
      'clientId': 'set clientId(dynamic value)',
      'language': 'set language(dynamic value)',
      'country': 'set country(dynamic value)',
      'timezone': 'set timezone(dynamic value)',
      'clientLanguage': 'set clientLanguage(dynamic value)',
      'clientCountry': 'set clientCountry(dynamic value)',
      'clientTimezone': 'set clientTimezone(dynamic value)',
      'aci': 'set aci(dynamic value)',
    },
  );
}

// =============================================================================
// TomGetSettingsMessage Bridge
// =============================================================================

BridgedClass _createTomGetSettingsMessageBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_26.TomGetSettingsMessage,
    name: 'TomGetSettingsMessage',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_26.TomGetSettingsMessage();
      },
    },
    getters: {
      'authorizationToken': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsMessage>(target, 'TomGetSettingsMessage').authorizationToken,
    },
    setters: {
      'authorizationToken': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsMessage>(target, 'TomGetSettingsMessage').authorizationToken = value as String?,
    },
    constructorSignatures: {
      '': 'TomGetSettingsMessage()',
    },
    getterSignatures: {
      'authorizationToken': 'String? get authorizationToken',
    },
    setterSignatures: {
      'authorizationToken': 'set authorizationToken(dynamic value)',
    },
  );
}

// =============================================================================
// TomGetSettingsResult Bridge
// =============================================================================

BridgedClass _createTomGetSettingsResultBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_26.TomGetSettingsResult,
    name: 'TomGetSettingsResult',
    constructors: {
      '': (visitor, positional, named) {
        final texts = named.containsKey('texts') && named['texts'] != null
            ? D4.coerceMap<String, Object?>(named['texts'], 'texts')
            : const <String, Object?>{};
        final config = named.containsKey('config') && named['config'] != null
            ? D4.coerceMap<String, Object?>(named['config'], 'config')
            : const <String, Object?>{};
        final groups = named.containsKey('groups') && named['groups'] != null
            ? D4.coerceList<String>(named['groups'], 'groups')
            : const <String>[];
        final roles = named.containsKey('roles') && named['roles'] != null
            ? D4.coerceList<String>(named['roles'], 'roles')
            : const <String>[];
        final entitlements = named.containsKey('entitlements') && named['entitlements'] != null
            ? D4.coerceList<String>(named['entitlements'], 'entitlements')
            : const <String>[];
        final resourceKeys = named.containsKey('resourceKeys') && named['resourceKeys'] != null
            ? D4.coerceList<String>(named['resourceKeys'], 'resourceKeys')
            : const <String>[];
        final organization = D4.getOptionalNamedArg<String?>(named, 'organization');
        final process = D4.getOptionalNamedArg<String?>(named, 'process');
        final application = D4.getOptionalNamedArg<String?>(named, 'application');
        final country = D4.getOptionalNamedArg<String?>(named, 'country');
        final language = D4.getOptionalNamedArg<String?>(named, 'language');
        final clientLanguage = D4.getOptionalNamedArg<String?>(named, 'clientLanguage');
        final clientCountry = D4.getOptionalNamedArg<String?>(named, 'clientCountry');
        final clientTimeZone = D4.getOptionalNamedArg<String?>(named, 'clientTimeZone');
        return $tom_core_kernel_26.TomGetSettingsResult(texts: texts, config: config, groups: groups, roles: roles, entitlements: entitlements, resourceKeys: resourceKeys, organization: organization, process: process, application: application, country: country, language: language, clientLanguage: clientLanguage, clientCountry: clientCountry, clientTimeZone: clientTimeZone);
      },
    },
    getters: {
      'texts': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').texts,
      'config': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').config,
      'groups': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').groups,
      'roles': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').roles,
      'entitlements': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').entitlements,
      'resourceKeys': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').resourceKeys,
      'organization': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').organization,
      'process': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').process,
      'application': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').application,
      'country': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').country,
      'language': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').language,
      'clientCountry': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').clientCountry,
      'clientLanguage': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').clientLanguage,
      'clientTimeZone': (visitor, target) => D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').clientTimeZone,
    },
    setters: {
      'texts': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').texts = (value as Map).cast<String, Object?>(),
      'config': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').config = (value as Map).cast<String, Object?>(),
      'groups': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').groups = (value as List).cast<String>().toList(),
      'roles': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').roles = (value as List).cast<String>().toList(),
      'entitlements': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').entitlements = (value as List).cast<String>().toList(),
      'resourceKeys': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').resourceKeys = (value as List).cast<String>().toList(),
      'organization': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').organization = value as String?,
      'process': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').process = value as String?,
      'application': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').application = value as String?,
      'country': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').country = value as String?,
      'language': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').language = value as String?,
      'clientCountry': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').clientCountry = value as String?,
      'clientLanguage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').clientLanguage = value as String?,
      'clientTimeZone': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_26.TomGetSettingsResult>(target, 'TomGetSettingsResult').clientTimeZone = value as String?,
    },
    constructorSignatures: {
      '': 'TomGetSettingsResult({Map<String, Object?> texts = const <String, Object?>{}, Map<String, Object?> config = const <String, Object?>{}, List<String> groups = const <String>[], List<String> roles = const <String>[], List<String> entitlements = const <String>[], List<String> resourceKeys = const <String>[], String? organization, String? process, String? application, String? country, String? language, String? clientLanguage, String? clientCountry, String? clientTimeZone})',
    },
    getterSignatures: {
      'texts': 'Map<String, Object?> get texts',
      'config': 'Map<String, Object?> get config',
      'groups': 'List<String> get groups',
      'roles': 'List<String> get roles',
      'entitlements': 'List<String> get entitlements',
      'resourceKeys': 'List<String> get resourceKeys',
      'organization': 'String? get organization',
      'process': 'String? get process',
      'application': 'String? get application',
      'country': 'String? get country',
      'language': 'String? get language',
      'clientCountry': 'String? get clientCountry',
      'clientLanguage': 'String? get clientLanguage',
      'clientTimeZone': 'String? get clientTimeZone',
    },
    setterSignatures: {
      'texts': 'set texts(dynamic value)',
      'config': 'set config(dynamic value)',
      'groups': 'set groups(dynamic value)',
      'roles': 'set roles(dynamic value)',
      'entitlements': 'set entitlements(dynamic value)',
      'resourceKeys': 'set resourceKeys(dynamic value)',
      'organization': 'set organization(dynamic value)',
      'process': 'set process(dynamic value)',
      'application': 'set application(dynamic value)',
      'country': 'set country(dynamic value)',
      'language': 'set language(dynamic value)',
      'clientCountry': 'set clientCountry(dynamic value)',
      'clientLanguage': 'set clientLanguage(dynamic value)',
      'clientTimeZone': 'set clientTimeZone(dynamic value)',
    },
  );
}

// =============================================================================
// TomDisposable Bridge
// =============================================================================

BridgedClass _createTomDisposableBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_27.TomDisposable,
    name: 'TomDisposable',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_27.TomDisposable>(target, 'TomDisposable');
        t.dispose();
        return null;
      },
    },
    methodSignatures: {
      'dispose': 'void dispose()',
    },
  );
}

// =============================================================================
// TomClosable Bridge
// =============================================================================

BridgedClass _createTomClosableBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_27.TomClosable,
    name: 'TomClosable',
    constructors: {
    },
    methods: {
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_27.TomClosable>(target, 'TomClosable');
        t.close();
        return null;
      },
    },
    methodSignatures: {
      'close': 'void close()',
    },
  );
}

// =============================================================================
// TomCloseAdaptor Bridge
// =============================================================================

BridgedClass _createTomCloseAdaptorBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_27.TomCloseAdaptor,
    name: 'TomCloseAdaptor',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomCloseAdaptor');
        final closableObject = D4.getRequiredArg<Object>(positional, 0, 'closableObject', 'TomCloseAdaptor');
        final methodName = D4.getOptionalArg<String?>(positional, 1, 'methodName');
        return $tom_core_kernel_27.TomCloseAdaptor(closableObject, methodName);
      },
    },
    getters: {
      'closableObject': (visitor, target) => D4.validateTarget<$tom_core_kernel_27.TomCloseAdaptor>(target, 'TomCloseAdaptor').closableObject,
    },
    setters: {
      'closableObject': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_27.TomCloseAdaptor>(target, 'TomCloseAdaptor').closableObject = value as Object,
    },
    methods: {
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_27.TomCloseAdaptor>(target, 'TomCloseAdaptor');
        t.close();
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomCloseAdaptor(Object closableObject, [String? methodName])',
    },
    methodSignatures: {
      'close': 'void close()',
    },
    getterSignatures: {
      'closableObject': 'Object get closableObject',
    },
    setterSignatures: {
      'closableObject': 'set closableObject(dynamic value)',
    },
  );
}

// =============================================================================
// TomShutdownCleanup Bridge
// =============================================================================

BridgedClass _createTomShutdownCleanupBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_27.TomShutdownCleanup,
    name: 'TomShutdownCleanup',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_27.TomShutdownCleanup();
      },
    },
    getters: {
      'paused': (visitor, target) => D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup').paused,
      'silent': (visitor, target) => D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup').silent,
    },
    setters: {
      'paused': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup').paused = value as bool,
      'silent': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup').silent = value as bool,
    },
    methods: {
      'performShutdown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup');
        t.performShutdown();
        return null;
      },
      'addSignalHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup');
        D4.requireMinArgs(positional, 1, 'addSignalHandler');
        if (positional.isEmpty) {
          throw ArgumentError('addSignalHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.addSignalHandler((ProcessSignal p0) { D4.callInterpreterCallback(visitor, handlerRaw, [p0]); });
        return null;
      },
      'addClosable': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup');
        D4.requireMinArgs(positional, 1, 'addClosable');
        final closable = D4.getRequiredArg<$tom_core_kernel_27.TomClosable>(positional, 0, 'closable', 'addClosable');
        t.addClosable(closable);
        return null;
      },
      'addDisposable': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup');
        D4.requireMinArgs(positional, 1, 'addDisposable');
        final disposable = D4.getRequiredArg<$tom_core_kernel_27.TomDisposable>(positional, 0, 'disposable', 'addDisposable');
        t.addDisposable(disposable);
        return null;
      },
      'addSignal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup');
        D4.requireMinArgs(positional, 1, 'addSignal');
        final processSignal = D4.getRequiredArg<ProcessSignal>(positional, 0, 'processSignal', 'addSignal');
        t.addSignal(processSignal);
        return null;
      },
      'start': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_27.TomShutdownCleanup>(target, 'TomShutdownCleanup');
        t.start();
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomShutdownCleanup()',
    },
    methodSignatures: {
      'performShutdown': 'void performShutdown()',
      'addSignalHandler': 'void addSignalHandler(TomSignalHandler handler)',
      'addClosable': 'void addClosable(TomClosable closable)',
      'addDisposable': 'void addDisposable(TomDisposable disposable)',
      'addSignal': 'void addSignal(ProcessSignal processSignal)',
      'start': 'void start()',
    },
    getterSignatures: {
      'paused': 'bool get paused',
      'silent': 'bool get silent',
    },
    setterSignatures: {
      'paused': 'set paused(dynamic value)',
      'silent': 'set silent(dynamic value)',
    },
  );
}

// =============================================================================
// TomObservable Bridge
// =============================================================================

BridgedClass _createTomObservableBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_18.TomObservable,
    name: 'TomObservable',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_18.TomObservable();
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_18.TomObservable>(target, 'TomObservable').isMuted,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_18.TomObservable>(target, 'TomObservable');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_18.TomObservable>(target, 'TomObservable');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_18.TomObservable>(target, 'TomObservable');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_18.TomObservable>(target, 'TomObservable');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_18.TomObservable>(target, 'TomObservable');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_18.TomObservable>(target, 'TomObservable');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
    },
    constructorSignatures: {
      '': 'TomObservable()',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver observer)',
      'removeObserver': 'void removeObserver(TomObserver observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
    },
  );
}

// =============================================================================
// TomObserver Bridge
// =============================================================================

BridgedClass _createTomObserverBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_18.TomObserver,
    name: 'TomObserver',
    constructors: {
    },
    methods: {
      'onNotify': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_18.TomObserver>(target, 'TomObserver');
        D4.requireMinArgs(positional, 1, 'onNotify');
        final observable = D4.getRequiredArg<$tom_core_kernel_18.TomObservable>(positional, 0, 'observable', 'onNotify');
        t.onNotify(observable);
        return null;
      },
    },
    methodSignatures: {
      'onNotify': 'void onNotify(T observable)',
    },
  );
}

// =============================================================================
// TomFunctionObserver Bridge
// =============================================================================

BridgedClass _createTomFunctionObserverBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_18.TomFunctionObserver,
    name: 'TomFunctionObserver',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomFunctionObserver');
        if (positional.isEmpty) {
          throw ArgumentError('TomFunctionObserver: Missing required argument "_callback" at position 0');
        }
        final callbackRaw = positional[0];
        return $tom_core_kernel_18.TomFunctionObserver(($tom_core_kernel_18.TomObservable p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
      },
    },
    methods: {
      'onNotify': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_18.TomFunctionObserver>(target, 'TomFunctionObserver');
        D4.requireMinArgs(positional, 1, 'onNotify');
        final observable = D4.getRequiredArg<$tom_core_kernel_18.TomObservable>(positional, 0, 'observable', 'onNotify');
        t.onNotify(observable);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomFunctionObserver(void Function(T) _callback)',
    },
    methodSignatures: {
      'onNotify': 'void onNotify(T observable)',
    },
  );
}

// =============================================================================
// TomReflectorException Bridge
// =============================================================================

BridgedClass _createTomReflectorExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_20.TomReflectorException,
    name: 'TomReflectorException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomReflectorException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomReflectorException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomReflectorException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        return $tom_core_kernel_20.TomReflectorException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectorException>(target, 'TomReflectorException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomReflectorException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomReflector Bridge
// =============================================================================

BridgedClass _createTomReflectorBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_20.TomReflector,
    name: 'TomReflector',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_20.TomReflector();
      },
    },
    getters: {
      'libraries': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflector>(target, 'TomReflector').libraries,
      'annotatedClasses': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflector>(target, 'TomReflector').annotatedClasses,
      'capabilities': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflector>(target, 'TomReflector').capabilities,
    },
    methods: {
      'canReflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflector>(target, 'TomReflector');
        D4.requireMinArgs(positional, 1, 'canReflect');
        final reflectee = D4.getRequiredArg<Object>(positional, 0, 'reflectee', 'canReflect');
        return t.canReflect(reflectee);
      },
      'reflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflector>(target, 'TomReflector');
        D4.requireMinArgs(positional, 1, 'reflect');
        final reflectee = D4.getRequiredArg<Object>(positional, 0, 'reflectee', 'reflect');
        return t.reflect(reflectee);
      },
      'canReflectType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflector>(target, 'TomReflector');
        D4.requireMinArgs(positional, 1, 'canReflectType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'canReflectType');
        return t.canReflectType(type);
      },
      'reflectType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflector>(target, 'TomReflector');
        D4.requireMinArgs(positional, 1, 'reflectType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'reflectType');
        return t.reflectType(type);
      },
      'findLibrary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflector>(target, 'TomReflector');
        D4.requireMinArgs(positional, 1, 'findLibrary');
        final libraryName = D4.getRequiredArg<String>(positional, 0, 'libraryName', 'findLibrary');
        return t.findLibrary(libraryName);
      },
    },
    constructorSignatures: {
      '': 'const TomReflector()',
    },
    methodSignatures: {
      'canReflect': 'bool canReflect(Object reflectee)',
      'reflect': 'InstanceMirror reflect(Object reflectee)',
      'canReflectType': 'bool canReflectType(Type type)',
      'reflectType': 'TypeMirror<dynamic> reflectType(Type type)',
      'findLibrary': 'LibraryMirror findLibrary(String libraryName)',
    },
    getterSignatures: {
      'libraries': 'Map<Uri, LibraryMirror> get libraries',
      'annotatedClasses': 'Iterable<ClassMirror<dynamic>> get annotatedClasses',
      'capabilities': 'List<ReflectCapability> get capabilities',
    },
  );
}

// =============================================================================
// TomReflectionInfo Bridge
// =============================================================================

BridgedClass _createTomReflectionInfoBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_20.TomReflectionInfo,
    name: 'TomReflectionInfo',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomReflectionInfo');
        final reflector = D4.getRequiredArg<$tom_core_kernel_20.TomReflector>(positional, 0, 'reflector', 'TomReflectionInfo');
        return $tom_core_kernel_20.TomReflectionInfo(reflector);
      },
    },
    getters: {
      'reflector': (visitor, target) => D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo').reflector,
    },
    methods: {
      'mapValueElementType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 1, 'mapValueElementType');
        final collection = D4.getRequiredArg<Object>(positional, 0, 'collection', 'mapValueElementType');
        return t.mapValueElementType(collection);
      },
      'singleElementType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 1, 'singleElementType');
        final collection = D4.getRequiredArg<Object>(positional, 0, 'collection', 'singleElementType');
        return t.singleElementType(collection);
      },
      'reportReflectObject': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 1, 'reportReflectObject');
        final o = D4.getRequiredArg<Object>(positional, 0, 'o', 'reportReflectObject');
        t.reportReflectObject(o);
        return null;
      },
      'reportReflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 1, 'reportReflect');
        final cm = D4.getRequiredArg<$tom_reflection_2.ClassMirror>(positional, 0, 'cm', 'reportReflect');
        t.reportReflect(cm);
        return null;
      },
      'convertFromJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 2, 'convertFromJsonString');
        final o = D4.getRequiredArg<Object>(positional, 0, 'o', 'convertFromJsonString');
        final s = D4.getRequiredArg<String>(positional, 1, 's', 'convertFromJsonString');
        return t.convertFromJsonString(o, s);
      },
      'createInstanceFromJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 2, 'createInstanceFromJsonString');
        final objectMirror = D4.getRequiredArg<$tom_reflection_2.ClassMirror>(positional, 0, 'objectMirror', 'createInstanceFromJsonString');
        final s = D4.getRequiredArg<String>(positional, 1, 's', 'createInstanceFromJsonString');
        return t.createInstanceFromJsonString(objectMirror, s);
      },
      'createInstanceFromJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 2, 'createInstanceFromJson');
        final objectMirror = D4.getRequiredArg<$tom_reflection_2.ClassMirror>(positional, 0, 'objectMirror', 'createInstanceFromJson');
        if (positional.length <= 1) {
          throw ArgumentError('createInstanceFromJson: Missing required argument "jsonData" at position 1');
        }
        final jsonData = D4.coerceMap<String, Object?>(positional[1], 'jsonData');
        return t.createInstanceFromJson(objectMirror, jsonData);
      },
      'createInstance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        final type = D4.getOptionalArg<Type?>(positional, 0, 'type');
        return t.createInstance(type);
      },
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 2, 'setValues');
        final o = D4.getRequiredArg<Object>(positional, 0, 'o', 'setValues');
        if (positional.length <= 1) {
          throw ArgumentError('setValues: Missing required argument "values" at position 1');
        }
        final values = D4.coerceMap<String, dynamic>(positional[1], 'values');
        return t.setValues(o, values);
      },
      'convertToJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 1, 'convertToJsonString');
        final o = D4.getRequiredArg<Object>(positional, 0, 'o', 'convertToJsonString');
        return t.convertToJsonString(o);
      },
      'getValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_20.TomReflectionInfo>(target, 'TomReflectionInfo');
        D4.requireMinArgs(positional, 1, 'getValues');
        final o = D4.getRequiredArg<Object>(positional, 0, 'o', 'getValues');
        return t.getValues(o);
      },
    },
    staticGetters: {
      'debugSwitchLogReflectionDetailsMembers': (visitor) => $tom_core_kernel_20.TomReflectionInfo.debugSwitchLogReflectionDetailsMembers,
      'debugSwitchLogReflectionDetailsValues': (visitor) => $tom_core_kernel_20.TomReflectionInfo.debugSwitchLogReflectionDetailsValues,
      'debugSwitchLogReflectionDetailsTypes': (visitor) => $tom_core_kernel_20.TomReflectionInfo.debugSwitchLogReflectionDetailsTypes,
    },
    staticSetters: {
      'debugSwitchLogReflectionDetailsMembers': (visitor, value) => 
        $tom_core_kernel_20.TomReflectionInfo.debugSwitchLogReflectionDetailsMembers = value as bool,
      'debugSwitchLogReflectionDetailsValues': (visitor, value) => 
        $tom_core_kernel_20.TomReflectionInfo.debugSwitchLogReflectionDetailsValues = value as bool,
      'debugSwitchLogReflectionDetailsTypes': (visitor, value) => 
        $tom_core_kernel_20.TomReflectionInfo.debugSwitchLogReflectionDetailsTypes = value as bool,
    },
    constructorSignatures: {
      '': 'TomReflectionInfo(TomReflector reflector)',
    },
    methodSignatures: {
      'mapValueElementType': 'ClassMirror mapValueElementType(Object collection)',
      'singleElementType': 'ClassMirror singleElementType(Object collection)',
      'reportReflectObject': 'void reportReflectObject(Object o)',
      'reportReflect': 'void reportReflect(ClassMirror cm)',
      'convertFromJsonString': 'T convertFromJsonString(T o, String s)',
      'createInstanceFromJsonString': 'T? createInstanceFromJsonString(ClassMirror objectMirror, String s)',
      'createInstanceFromJson': 'T? createInstanceFromJson(ClassMirror objectMirror, Map<String, Object?> jsonData)',
      'createInstance': 'T createInstance([Type? type])',
      'setValues': 'T setValues(T o, Map<String, dynamic> values)',
      'convertToJsonString': 'String convertToJsonString(Object o)',
      'getValues': 'Map<String, Object?> getValues(Object o)',
    },
    getterSignatures: {
      'reflector': 'TomReflector get reflector',
    },
    staticGetterSignatures: {
      'debugSwitchLogReflectionDetailsMembers': 'bool get debugSwitchLogReflectionDetailsMembers',
      'debugSwitchLogReflectionDetailsValues': 'bool get debugSwitchLogReflectionDetailsValues',
      'debugSwitchLogReflectionDetailsTypes': 'bool get debugSwitchLogReflectionDetailsTypes',
    },
    staticSetterSignatures: {
      'debugSwitchLogReflectionDetailsMembers': 'set debugSwitchLogReflectionDetailsMembers(dynamic value)',
      'debugSwitchLogReflectionDetailsValues': 'set debugSwitchLogReflectionDetailsValues(dynamic value)',
      'debugSwitchLogReflectionDetailsTypes': 'set debugSwitchLogReflectionDetailsTypes(dynamic value)',
    },
  );
}

// =============================================================================
// TomObservableException Bridge
// =============================================================================

BridgedClass _createTomObservableExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomObservableException,
    name: 'TomObservableException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomObservableException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomObservableException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomObservableException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        final uuid = D4.getOptionalNamedArg<String?>(named, 'uuid');
        final serverCallError = D4.getOptionalNamedArg<$tom_core_kernel_8.TomServerCallError?>(named, 'serverCallError');
        return $tom_core_kernel_19.TomObservableException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog, uuid: uuid, serverCallError: serverCallError);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObservableException>(target, 'TomObservableException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomObservableException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false, String? uuid, TomServerCallError? serverCallError})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomObject Bridge
// =============================================================================

BridgedClass _createTomObjectBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomObject,
    name: 'TomObject',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomObject');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'TomObject');
        return $tom_core_kernel_19.TomObject(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomObject>(target, 'TomObject');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomObject(T initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'T get()',
      'set': 'T set(T value)',
      'getOrNull': 'T? getOrNull()',
      'call': 'T call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomString Bridge
// =============================================================================

BridgedClass _createTomStringBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomString,
    name: 'TomString',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomString');
        final initialValue = D4.getRequiredArg<String>(positional, 0, 'initialValue', 'TomString');
        return $tom_core_kernel_19.TomString(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<String>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        final other = D4.getRequiredArg<String>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomString>(target, 'TomString');
        final other = D4.getRequiredArg<String>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomString(String initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'String get()',
      'set': 'String set(String value)',
      'getOrNull': 'String getOrNull()',
      'call': 'String call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomInt Bridge
// =============================================================================

BridgedClass _createTomIntBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomInt,
    name: 'TomInt',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomInt');
        final initialValue = D4.getRequiredArg<int>(positional, 0, 'initialValue', 'TomInt');
        return $tom_core_kernel_19.TomInt(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomInt>(target, 'TomInt');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomInt(int initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'int get()',
      'set': 'int set(int value)',
      'getOrNull': 'int getOrNull()',
      'call': 'int call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomDouble Bridge
// =============================================================================

BridgedClass _createTomDoubleBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomDouble,
    name: 'TomDouble',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomDouble');
        final initialValue = D4.getRequiredArg<double>(positional, 0, 'initialValue', 'TomDouble');
        return $tom_core_kernel_19.TomDouble(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDouble>(target, 'TomDouble');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomDouble(double initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'double get()',
      'set': 'double set(double value)',
      'getOrNull': 'double getOrNull()',
      'call': 'double call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomBool Bridge
// =============================================================================

BridgedClass _createTomBoolBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomBool,
    name: 'TomBool',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomBool');
        final initialValue = D4.getRequiredArg<bool>(positional, 0, 'initialValue', 'TomBool');
        return $tom_core_kernel_19.TomBool(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<bool>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        final other = D4.getRequiredArg<bool>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomBool>(target, 'TomBool');
        final other = D4.getRequiredArg<bool>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomBool(bool initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'bool get()',
      'set': 'bool set(bool value)',
      'getOrNull': 'bool getOrNull()',
      'call': 'bool call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomDateTime Bridge
// =============================================================================

BridgedClass _createTomDateTimeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomDateTime,
    name: 'TomDateTime',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomDateTime');
        final initialValue = D4.getRequiredArg<DateTime>(positional, 0, 'initialValue', 'TomDateTime');
        return $tom_core_kernel_19.TomDateTime(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<DateTime>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTime>(target, 'TomDateTime');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noDateTime': (visitor) => $tom_core_kernel_19.TomDateTime.noDateTime,
      'serializationPrefix': (visitor) => $tom_core_kernel_19.TomDateTime.serializationPrefix,
    },
    constructorSignatures: {
      '': 'TomDateTime(DateTime initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'DateTime get()',
      'set': 'DateTime set(DateTime value)',
      'getOrNull': 'DateTime getOrNull()',
      'call': 'DateTime call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noDateTime': 'TomDateTime get noDateTime',
      'serializationPrefix': 'String get serializationPrefix',
    },
  );
}

// =============================================================================
// TomOTimezoned Bridge
// =============================================================================

BridgedClass _createTomOTimezonedBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomOTimezoned,
    name: 'TomOTimezoned',
    constructors: {
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<$tom_core_kernel_28.TomTimezoned>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        return t.toString();
      },
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        return t.getSerializationPrefix();
      },
      'setByString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        D4.requireMinArgs(positional, 1, 'setByString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'setByString');
        t.setByString(s);
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomTimezoned>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOTimezoned>(target, 'TomOTimezoned');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomTimezoned>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noDateTime': (visitor) => $tom_core_kernel_19.TomOTimezoned.noDateTime,
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'TZ get()',
      'set': 'TZ set(TZ value)',
      'getOrNull': 'TZ getOrNull()',
      'call': 'TZ call()',
      'toString': 'String toString()',
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'setByString': 'void setByString(String s)',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noDateTime': 'TomOTimezoned get noDateTime',
    },
  );
}

// =============================================================================
// TomOZonedTime Bridge
// =============================================================================

BridgedClass _createTomOZonedTimeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomOZonedTime,
    name: 'TomOZonedTime',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomOZonedTime');
        final initialValue = D4.getRequiredArg<$tom_core_kernel_28.TomZonedTime>(positional, 0, 'initialValue', 'TomOZonedTime');
        return $tom_core_kernel_19.TomOZonedTime(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<$tom_core_kernel_28.TomZonedTime>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        return t.toString();
      },
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        return t.getSerializationPrefix();
      },
      'setByString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        D4.requireMinArgs(positional, 1, 'setByString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'setByString');
        t.setByString(s);
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedTime>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedTime>(target, 'TomOZonedTime');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedTime>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noZonedTime': (visitor) => $tom_core_kernel_19.TomOZonedTime.noZonedTime,
      'noTime': (visitor) => $tom_core_kernel_19.TomOZonedTime.noTime,
    },
    constructorSignatures: {
      '': 'TomOZonedTime(TomZonedTime initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'TomZonedTime get()',
      'set': 'TomZonedTime set(TomZonedTime value)',
      'getOrNull': 'TomZonedTime getOrNull()',
      'call': 'TomZonedTime call()',
      'toString': 'String toString()',
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'setByString': 'void setByString(String s)',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noZonedTime': 'TomZonedTime get noZonedTime',
      'noTime': 'TomOZonedTime get noTime',
    },
  );
}

// =============================================================================
// TomOZonedDate Bridge
// =============================================================================

BridgedClass _createTomOZonedDateBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomOZonedDate,
    name: 'TomOZonedDate',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomOZonedDate');
        final initialValue = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDate>(positional, 0, 'initialValue', 'TomOZonedDate');
        return $tom_core_kernel_19.TomOZonedDate(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDate>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        return t.toString();
      },
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        return t.getSerializationPrefix();
      },
      'setByString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        D4.requireMinArgs(positional, 1, 'setByString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'setByString');
        t.setByString(s);
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDate>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDate>(target, 'TomOZonedDate');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDate>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noZonedDate': (visitor) => $tom_core_kernel_19.TomOZonedDate.noZonedDate,
      'noTime': (visitor) => $tom_core_kernel_19.TomOZonedDate.noTime,
    },
    constructorSignatures: {
      '': 'TomOZonedDate(TomZonedDate initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'TomZonedDate get()',
      'set': 'TomZonedDate set(TomZonedDate value)',
      'getOrNull': 'TomZonedDate getOrNull()',
      'call': 'TomZonedDate call()',
      'toString': 'String toString()',
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'setByString': 'void setByString(String s)',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noZonedDate': 'TomZonedDate get noZonedDate',
      'noTime': 'TomOZonedDate get noTime',
    },
  );
}

// =============================================================================
// TomOZonedDateTime Bridge
// =============================================================================

BridgedClass _createTomOZonedDateTimeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomOZonedDateTime,
    name: 'TomOZonedDateTime',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomOZonedDateTime');
        final initialValue = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDateTime>(positional, 0, 'initialValue', 'TomOZonedDateTime');
        return $tom_core_kernel_19.TomOZonedDateTime(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDateTime>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        return t.toString();
      },
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        return t.getSerializationPrefix();
      },
      'setByString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        D4.requireMinArgs(positional, 1, 'setByString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'setByString');
        t.setByString(s);
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDateTime>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomOZonedDateTime>(target, 'TomOZonedDateTime');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDateTime>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noZonedDateTime': (visitor) => $tom_core_kernel_19.TomOZonedDateTime.noZonedDateTime,
      'noTime': (visitor) => $tom_core_kernel_19.TomOZonedDateTime.noTime,
    },
    constructorSignatures: {
      '': 'TomOZonedDateTime(TomZonedDateTime initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'TomZonedDateTime get()',
      'set': 'TomZonedDateTime set(TomZonedDateTime value)',
      'getOrNull': 'TomZonedDateTime getOrNull()',
      'call': 'TomZonedDateTime call()',
      'toString': 'String toString()',
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'setByString': 'void setByString(String s)',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noZonedDateTime': 'TomZonedDateTime get noZonedDateTime',
      'noTime': 'TomOZonedDateTime get noTime',
    },
  );
}

// =============================================================================
// TomNString Bridge
// =============================================================================

BridgedClass _createTomNStringBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomNString,
    name: 'TomNString',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomNString');
        final initialValue = D4.getRequiredArg<String?>(positional, 0, 'initialValue', 'TomNString');
        return $tom_core_kernel_19.TomNString(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<String?>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        final other = D4.getRequiredArg<String?>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNString>(target, 'TomNString');
        final other = D4.getRequiredArg<String?>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomNString(String? initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'String? get()',
      'set': 'String? set(String? value)',
      'getOrNull': 'String? getOrNull()',
      'call': 'String? call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomNInt Bridge
// =============================================================================

BridgedClass _createTomNIntBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomNInt,
    name: 'TomNInt',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomNInt');
        final initialValue = D4.getRequiredArg<int?>(positional, 0, 'initialValue', 'TomNInt');
        return $tom_core_kernel_19.TomNInt(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<int?>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        final other = D4.getRequiredArg<int?>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNInt>(target, 'TomNInt');
        final other = D4.getRequiredArg<int?>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomNInt(int? initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'int? get()',
      'set': 'int? set(int? value)',
      'getOrNull': 'int? getOrNull()',
      'call': 'int? call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomNDouble Bridge
// =============================================================================

BridgedClass _createTomNDoubleBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomNDouble,
    name: 'TomNDouble',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomNDouble');
        final initialValue = D4.getRequiredArg<double?>(positional, 0, 'initialValue', 'TomNDouble');
        return $tom_core_kernel_19.TomNDouble(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<double?>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        final other = D4.getRequiredArg<double?>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDouble>(target, 'TomNDouble');
        final other = D4.getRequiredArg<double?>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomNDouble(double? initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'double? get()',
      'set': 'double? set(double? value)',
      'getOrNull': 'double? getOrNull()',
      'call': 'double? call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomNBool Bridge
// =============================================================================

BridgedClass _createTomNBoolBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomNBool,
    name: 'TomNBool',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomNBool');
        final initialValue = D4.getRequiredArg<bool?>(positional, 0, 'initialValue', 'TomNBool');
        return $tom_core_kernel_19.TomNBool(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<bool?>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        final other = D4.getRequiredArg<bool?>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNBool>(target, 'TomNBool');
        final other = D4.getRequiredArg<bool?>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomNBool(bool? initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'bool? get()',
      'set': 'bool? set(bool? value)',
      'getOrNull': 'bool? getOrNull()',
      'call': 'bool? call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomNDateTime Bridge
// =============================================================================

BridgedClass _createTomNDateTimeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomNDateTime,
    name: 'TomNDateTime',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomNDateTime');
        final initialValue = D4.getRequiredArg<DateTime?>(positional, 0, 'initialValue', 'TomNDateTime');
        return $tom_core_kernel_19.TomNDateTime(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<DateTime?>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        return t.toString();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        final other = D4.getRequiredArg<DateTime?>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNDateTime>(target, 'TomNDateTime');
        final other = D4.getRequiredArg<DateTime?>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noDateTime': (visitor) => $tom_core_kernel_19.TomNDateTime.noDateTime,
      'serializationPrefix': (visitor) => $tom_core_kernel_19.TomNDateTime.serializationPrefix,
    },
    constructorSignatures: {
      '': 'TomNDateTime(DateTime? initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'DateTime? get()',
      'set': 'DateTime? set(DateTime? value)',
      'getOrNull': 'DateTime? getOrNull()',
      'call': 'DateTime? call()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noDateTime': 'TomDateTime get noDateTime',
      'serializationPrefix': 'String get serializationPrefix',
    },
  );
}

// =============================================================================
// TomNOTimezoned Bridge
// =============================================================================

BridgedClass _createTomNOTimezonedBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomNOTimezoned,
    name: 'TomNOTimezoned',
    constructors: {
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<$tom_core_kernel_28.TomTimezoned>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        return t.toString();
      },
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        return t.getSerializationPrefix();
      },
      'setByString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        D4.requireMinArgs(positional, 1, 'setByString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'setByString');
        t.setByString(s);
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomTimezoned>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOTimezoned>(target, 'TomNOTimezoned');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomTimezoned>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noDateTime': (visitor) => $tom_core_kernel_19.TomNOTimezoned.noDateTime,
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'TZ get()',
      'set': 'TZ set(TZ value)',
      'getOrNull': 'TZ getOrNull()',
      'call': 'TZ call()',
      'toString': 'String toString()',
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'setByString': 'void setByString(String s)',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noDateTime': 'TomNOTimezoned get noDateTime',
    },
  );
}

// =============================================================================
// TomNOZonedTime Bridge
// =============================================================================

BridgedClass _createTomNOZonedTimeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomNOZonedTime,
    name: 'TomNOZonedTime',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomNOZonedTime');
        final initialValue = D4.getRequiredArg<$tom_core_kernel_28.TomZonedTime?>(positional, 0, 'initialValue', 'TomNOZonedTime');
        return $tom_core_kernel_19.TomNOZonedTime(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<$tom_core_kernel_28.TomZonedTime?>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        return t.toString();
      },
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        return t.getSerializationPrefix();
      },
      'setByString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        D4.requireMinArgs(positional, 1, 'setByString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'setByString');
        t.setByString(s);
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedTime?>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedTime>(target, 'TomNOZonedTime');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedTime?>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noZonedTime': (visitor) => $tom_core_kernel_19.TomNOZonedTime.noZonedTime,
      'noTime': (visitor) => $tom_core_kernel_19.TomNOZonedTime.noTime,
    },
    constructorSignatures: {
      '': 'TomNOZonedTime(TomZonedTime? initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'TomZonedTime? get()',
      'set': 'TomZonedTime? set(TomZonedTime? value)',
      'getOrNull': 'TomZonedTime? getOrNull()',
      'call': 'TomZonedTime? call()',
      'toString': 'String toString()',
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'setByString': 'void setByString(String s)',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noZonedTime': 'TomZonedTime get noZonedTime',
      'noTime': 'TomNOZonedTime get noTime',
    },
  );
}

// =============================================================================
// TomNOZonedDate Bridge
// =============================================================================

BridgedClass _createTomNOZonedDateBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomNOZonedDate,
    name: 'TomNOZonedDate',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomNOZonedDate');
        final initialValue = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDate?>(positional, 0, 'initialValue', 'TomNOZonedDate');
        return $tom_core_kernel_19.TomNOZonedDate(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDate?>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        return t.toString();
      },
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        return t.getSerializationPrefix();
      },
      'setByString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        D4.requireMinArgs(positional, 1, 'setByString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'setByString');
        t.setByString(s);
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDate?>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDate>(target, 'TomNOZonedDate');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDate?>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noZonedDate': (visitor) => $tom_core_kernel_19.TomNOZonedDate.noZonedDate,
      'noTime': (visitor) => $tom_core_kernel_19.TomNOZonedDate.noTime,
    },
    constructorSignatures: {
      '': 'TomNOZonedDate(TomZonedDate? initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'TomZonedDate? get()',
      'set': 'TomZonedDate? set(TomZonedDate? value)',
      'getOrNull': 'TomZonedDate? getOrNull()',
      'call': 'TomZonedDate? call()',
      'toString': 'String toString()',
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'setByString': 'void setByString(String s)',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noZonedDate': 'TomZonedDate get noZonedDate',
      'noTime': 'TomNOZonedDate get noTime',
    },
  );
}

// =============================================================================
// TomNOZonedDateTime Bridge
// =============================================================================

BridgedClass _createTomNOZonedDateTimeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomNOZonedDateTime,
    name: 'TomNOZonedDateTime',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomNOZonedDateTime');
        final initialValue = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDateTime?>(positional, 0, 'initialValue', 'TomNOZonedDateTime');
        return $tom_core_kernel_19.TomNOZonedDateTime(initialValue);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        D4.requireMinArgs(positional, 1, 'set');
        final value = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDateTime?>(positional, 0, 'value', 'set');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        return t.toString();
      },
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        return t.getSerializationPrefix();
      },
      'setByString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        D4.requireMinArgs(positional, 1, 'setByString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'setByString');
        t.setByString(s);
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDateTime?>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomNOZonedDateTime>(target, 'TomNOZonedDateTime');
        final other = D4.getRequiredArg<$tom_core_kernel_28.TomZonedDateTime?>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    staticGetters: {
      'noZonedDateTime': (visitor) => $tom_core_kernel_19.TomNOZonedDateTime.noZonedDateTime,
      'noTime': (visitor) => $tom_core_kernel_19.TomNOZonedDateTime.noTime,
    },
    constructorSignatures: {
      '': 'TomNOZonedDateTime(TomZonedDateTime? initialValue)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'TomZonedDateTime? get()',
      'set': 'TomZonedDateTime? set(TomZonedDateTime? value)',
      'getOrNull': 'TomZonedDateTime? getOrNull()',
      'call': 'TomZonedDateTime? call()',
      'toString': 'String toString()',
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'setByString': 'void setByString(String s)',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
    staticGetterSignatures: {
      'noZonedDateTime': 'TomZonedDateTime get noZonedDateTime',
      'noTime': 'TomNOZonedDateTime get noTime',
    },
  );
}

// =============================================================================
// TomDateRange Bridge
// =============================================================================

BridgedClass _createTomDateRangeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomDateRange,
    name: 'TomDateRange',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_19.TomDateRange();
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange').isNull,
      'startDate': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange').startDate,
      'endDate': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange').endDate,
    },
    setters: {
      'startDate': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange').startDate = value as $tom_core_kernel_19.TomNOZonedDate,
      'endDate': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange').endDate = value as $tom_core_kernel_19.TomNOZonedDate,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        D4.requireMinArgs(positional, 1, 'set');
        if (positional.isEmpty) {
          throw ArgumentError('set: Missing required argument "value" at position 0');
        }
        final value = D4.coerceMap<String, $tom_core_kernel_19.TomObject<dynamic>>(positional[0], 'value');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        return t.toString();
      },
      'startSelfObservation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        t.startSelfObservation();
        return null;
      },
      'getMembers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        return t.getMembers();
      },
      'onNotify': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        D4.requireMinArgs(positional, 1, 'onNotify');
        final observable = D4.getRequiredArg<$tom_core_kernel_18.TomObservable>(positional, 0, 'observable', 'onNotify');
        t.onNotify(observable);
        return null;
      },
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        D4.requireMinArgs(positional, 1, 'setValues');
        if (positional.isEmpty) {
          throw ArgumentError('setValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<String, dynamic>(positional[0], 'values');
        t.setValues(values);
        return null;
      },
      'setOrMergeValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        D4.requireMinArgs(positional, 2, 'setOrMergeValues');
        if (positional.isEmpty) {
          throw ArgumentError('setOrMergeValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<String, dynamic>(positional[0], 'values');
        final merge = D4.getRequiredArg<bool>(positional, 1, 'merge', 'setOrMergeValues');
        t.setOrMergeValues(values, merge);
        return null;
      },
      'getValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        return t.getValues();
      },
      'fromJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        D4.requireMinArgs(positional, 1, 'fromJson');
        final json = D4.getRequiredArg<String>(positional, 0, 'json', 'fromJson');
        t.fromJson(json);
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        return t.toJson();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        final other = D4.getRequiredArg<Map<String, $tom_core_kernel_19.TomObject<dynamic>>>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateRange>(target, 'TomDateRange');
        final other = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomDateRange()',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'Map<String, TomObject<dynamic>> get()',
      'set': 'Map<String, TomObject<dynamic>> set(Map<String, TomObject<dynamic>> value)',
      'getOrNull': 'Map<String, TomObject<dynamic>> getOrNull()',
      'call': 'Map<String, TomObject<dynamic>> call()',
      'toString': 'String toString()',
      'startSelfObservation': 'void startSelfObservation()',
      'getMembers': 'Map<String, TomObject<dynamic>> getMembers()',
      'onNotify': 'void onNotify(TomObservable observable)',
      'setValues': 'void setValues(Map<String, dynamic> values)',
      'setOrMergeValues': 'void setOrMergeValues(Map<String, dynamic> values, bool merge)',
      'getValues': 'Map<String, dynamic> getValues()',
      'fromJson': 'void fromJson(String json)',
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
      'startDate': 'TomNOZonedDate get startDate',
      'endDate': 'TomNOZonedDate get endDate',
    },
    setterSignatures: {
      'startDate': 'set startDate(dynamic value)',
      'endDate': 'set endDate(dynamic value)',
    },
  );
}

// =============================================================================
// TomTimeRange Bridge
// =============================================================================

BridgedClass _createTomTimeRangeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomTimeRange,
    name: 'TomTimeRange',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_19.TomTimeRange();
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange').isNull,
      'startTime': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange').startTime,
      'endTime': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange').endTime,
    },
    setters: {
      'startTime': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange').startTime = value as $tom_core_kernel_19.TomNOZonedTime,
      'endTime': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange').endTime = value as $tom_core_kernel_19.TomNOZonedTime,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        D4.requireMinArgs(positional, 1, 'set');
        if (positional.isEmpty) {
          throw ArgumentError('set: Missing required argument "value" at position 0');
        }
        final value = D4.coerceMap<String, $tom_core_kernel_19.TomObject<dynamic>>(positional[0], 'value');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        return t.toString();
      },
      'startSelfObservation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        t.startSelfObservation();
        return null;
      },
      'getMembers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        return t.getMembers();
      },
      'onNotify': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        D4.requireMinArgs(positional, 1, 'onNotify');
        final observable = D4.getRequiredArg<$tom_core_kernel_18.TomObservable>(positional, 0, 'observable', 'onNotify');
        t.onNotify(observable);
        return null;
      },
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        D4.requireMinArgs(positional, 1, 'setValues');
        if (positional.isEmpty) {
          throw ArgumentError('setValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<String, dynamic>(positional[0], 'values');
        t.setValues(values);
        return null;
      },
      'setOrMergeValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        D4.requireMinArgs(positional, 2, 'setOrMergeValues');
        if (positional.isEmpty) {
          throw ArgumentError('setOrMergeValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<String, dynamic>(positional[0], 'values');
        final merge = D4.getRequiredArg<bool>(positional, 1, 'merge', 'setOrMergeValues');
        t.setOrMergeValues(values, merge);
        return null;
      },
      'getValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        return t.getValues();
      },
      'fromJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        D4.requireMinArgs(positional, 1, 'fromJson');
        final json = D4.getRequiredArg<String>(positional, 0, 'json', 'fromJson');
        t.fromJson(json);
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        return t.toJson();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        final other = D4.getRequiredArg<Map<String, $tom_core_kernel_19.TomObject<dynamic>>>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomTimeRange>(target, 'TomTimeRange');
        final other = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomTimeRange()',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'Map<String, TomObject<dynamic>> get()',
      'set': 'Map<String, TomObject<dynamic>> set(Map<String, TomObject<dynamic>> value)',
      'getOrNull': 'Map<String, TomObject<dynamic>> getOrNull()',
      'call': 'Map<String, TomObject<dynamic>> call()',
      'toString': 'String toString()',
      'startSelfObservation': 'void startSelfObservation()',
      'getMembers': 'Map<String, TomObject<dynamic>> getMembers()',
      'onNotify': 'void onNotify(TomObservable observable)',
      'setValues': 'void setValues(Map<String, dynamic> values)',
      'setOrMergeValues': 'void setOrMergeValues(Map<String, dynamic> values, bool merge)',
      'getValues': 'Map<String, dynamic> getValues()',
      'fromJson': 'void fromJson(String json)',
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
      'startTime': 'TomNOZonedTime get startTime',
      'endTime': 'TomNOZonedTime get endTime',
    },
    setterSignatures: {
      'startTime': 'set startTime(dynamic value)',
      'endTime': 'set endTime(dynamic value)',
    },
  );
}

// =============================================================================
// TomDateTimeRange Bridge
// =============================================================================

BridgedClass _createTomDateTimeRangeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomDateTimeRange,
    name: 'TomDateTimeRange',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_19.TomDateTimeRange();
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange').isNull,
      'startDateTime': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange').startDateTime,
      'endDateTime': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange').endDateTime,
    },
    setters: {
      'startDateTime': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange').startDateTime = value as $tom_core_kernel_19.TomNOZonedDateTime,
      'endDateTime': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange').endDateTime = value as $tom_core_kernel_19.TomNOZonedDateTime,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        D4.requireMinArgs(positional, 1, 'set');
        if (positional.isEmpty) {
          throw ArgumentError('set: Missing required argument "value" at position 0');
        }
        final value = D4.coerceMap<String, $tom_core_kernel_19.TomObject<dynamic>>(positional[0], 'value');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        return t.toString();
      },
      'startSelfObservation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        t.startSelfObservation();
        return null;
      },
      'getMembers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        return t.getMembers();
      },
      'onNotify': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        D4.requireMinArgs(positional, 1, 'onNotify');
        final observable = D4.getRequiredArg<$tom_core_kernel_18.TomObservable>(positional, 0, 'observable', 'onNotify');
        t.onNotify(observable);
        return null;
      },
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        D4.requireMinArgs(positional, 1, 'setValues');
        if (positional.isEmpty) {
          throw ArgumentError('setValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<String, dynamic>(positional[0], 'values');
        t.setValues(values);
        return null;
      },
      'setOrMergeValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        D4.requireMinArgs(positional, 2, 'setOrMergeValues');
        if (positional.isEmpty) {
          throw ArgumentError('setOrMergeValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<String, dynamic>(positional[0], 'values');
        final merge = D4.getRequiredArg<bool>(positional, 1, 'merge', 'setOrMergeValues');
        t.setOrMergeValues(values, merge);
        return null;
      },
      'getValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        return t.getValues();
      },
      'fromJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        D4.requireMinArgs(positional, 1, 'fromJson');
        final json = D4.getRequiredArg<String>(positional, 0, 'json', 'fromJson');
        t.fromJson(json);
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        return t.toJson();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        final other = D4.getRequiredArg<Map<String, $tom_core_kernel_19.TomObject<dynamic>>>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomDateTimeRange>(target, 'TomDateTimeRange');
        final other = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomDateTimeRange()',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'Map<String, TomObject<dynamic>> get()',
      'set': 'Map<String, TomObject<dynamic>> set(Map<String, TomObject<dynamic>> value)',
      'getOrNull': 'Map<String, TomObject<dynamic>> getOrNull()',
      'call': 'Map<String, TomObject<dynamic>> call()',
      'toString': 'String toString()',
      'startSelfObservation': 'void startSelfObservation()',
      'getMembers': 'Map<String, TomObject<dynamic>> getMembers()',
      'onNotify': 'void onNotify(TomObservable observable)',
      'setValues': 'void setValues(Map<String, dynamic> values)',
      'setOrMergeValues': 'void setOrMergeValues(Map<String, dynamic> values, bool merge)',
      'getValues': 'Map<String, dynamic> getValues()',
      'fromJson': 'void fromJson(String json)',
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
      'startDateTime': 'TomNOZonedDateTime get startDateTime',
      'endDateTime': 'TomNOZonedDateTime get endDateTime',
    },
    setterSignatures: {
      'startDateTime': 'set startDateTime(dynamic value)',
      'endDateTime': 'set endDateTime(dynamic value)',
    },
  );
}

// =============================================================================
// TomClass Bridge
// =============================================================================

BridgedClass _createTomClassBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomClass,
    name: 'TomClass',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_19.TomClass();
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass').isNull,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        D4.requireMinArgs(positional, 1, 'set');
        if (positional.isEmpty) {
          throw ArgumentError('set: Missing required argument "value" at position 0');
        }
        final value = D4.coerceMap<String, $tom_core_kernel_19.TomObject>(positional[0], 'value');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        return t.toString();
      },
      'startSelfObservation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        t.startSelfObservation();
        return null;
      },
      'getMembers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        return t.getMembers();
      },
      'onNotify': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        D4.requireMinArgs(positional, 1, 'onNotify');
        final observable = D4.getRequiredArg<$tom_core_kernel_18.TomObservable>(positional, 0, 'observable', 'onNotify');
        t.onNotify(observable);
        return null;
      },
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        D4.requireMinArgs(positional, 1, 'setValues');
        if (positional.isEmpty) {
          throw ArgumentError('setValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<String, dynamic>(positional[0], 'values');
        t.setValues(values);
        return null;
      },
      'setOrMergeValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        D4.requireMinArgs(positional, 2, 'setOrMergeValues');
        if (positional.isEmpty) {
          throw ArgumentError('setOrMergeValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<String, dynamic>(positional[0], 'values');
        final merge = D4.getRequiredArg<bool>(positional, 1, 'merge', 'setOrMergeValues');
        t.setOrMergeValues(values, merge);
        return null;
      },
      'getValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        return t.getValues();
      },
      'fromJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        D4.requireMinArgs(positional, 1, 'fromJson');
        final json = D4.getRequiredArg<String>(positional, 0, 'json', 'fromJson');
        t.fromJson(json);
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        return t.toJson();
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        final other = D4.getRequiredArg<Map<String, $tom_core_kernel_19.TomObject<dynamic>>>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomClass>(target, 'TomClass');
        final other = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
    },
    constructorSignatures: {
      '': 'TomClass()',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'Map<String, TomObject> get()',
      'set': 'Map<String, TomObject> set(Map<String, TomObject> value)',
      'getOrNull': 'Map<String, TomObject<dynamic>> getOrNull()',
      'call': 'Map<String, TomObject<dynamic>> call()',
      'toString': 'String toString()',
      'startSelfObservation': 'void startSelfObservation()',
      'getMembers': 'Map<String, TomObject> getMembers()',
      'onNotify': 'void onNotify(TomObservable observable)',
      'setValues': 'void setValues(Map<String, dynamic> values)',
      'setOrMergeValues': 'void setOrMergeValues(Map<String, dynamic> values, bool merge)',
      'getValues': 'Map<String, dynamic> getValues()',
      'fromJson': 'void fromJson(String json)',
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
    },
  );
}

// =============================================================================
// TomList Bridge
// =============================================================================

BridgedClass _createTomListBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomList,
    name: 'TomList',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_19.TomList();
      },
      'from': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomList');
        final existing = D4.getRequiredArg<$tom_core_kernel_19.TomList<$tom_core_kernel_19.TomObject>>(positional, 0, 'existing', 'TomList');
        return $tom_core_kernel_19.TomList.from(existing);
      },
      'of': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomList');
        final existing = D4.getRequiredArg<$tom_core_kernel_19.TomList<$tom_core_kernel_19.TomObject>>(positional, 0, 'existing', 'TomList');
        return $tom_core_kernel_19.TomList.of(existing);
      },
      'ofList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomList');
        if (positional.isEmpty) {
          throw ArgumentError('TomList: Missing required argument "list" at position 0');
        }
        final list = D4.coerceList<$tom_core_kernel_19.TomObject>(positional[0], 'list');
        return $tom_core_kernel_19.TomList.ofList(list);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').isNull,
      'first': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').first,
      'last': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').last,
      'length': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').length,
      'reversed': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').reversed,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').hashCode,
      'isEmpty': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').isNotEmpty,
      'iterator': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').iterator,
      'single': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').single,
    },
    setters: {
      'first': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').first = value as dynamic,
      'last': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').last = value as dynamic,
      'length': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList').length = value as dynamic,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'set');
        if (positional.isEmpty) {
          throw ArgumentError('set: Missing required argument "value" at position 0');
        }
        final value = D4.coerceList<$tom_core_kernel_19.TomObject>(positional[0], 'value');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.toString();
      },
      'onNotify': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'onNotify');
        final observable = D4.getRequiredArg<$tom_core_kernel_18.TomObservable>(positional, 0, 'observable', 'onNotify');
        t.onNotify(observable);
        return null;
      },
      'append': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'append');
        final element = D4.getRequiredArg<$tom_core_kernel_19.TomObject>(positional, 0, 'element', 'append');
        return t.append(element);
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.cast();
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'contains');
        final o = D4.getRequiredArg<Object?>(positional, 0, 'o', 'contains');
        return t.contains(o);
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "toElements" at position 0');
        }
        final toElementsRaw = positional[0];
        return t.expand(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, $tom_core_kernel_19.TomObject p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'followedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'followedBy');
        final other = D4.getRequiredArg<Iterable<dynamic>>(positional, 0, 'other', 'followedBy');
        return t.followedBy(other);
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach(($tom_core_kernel_19.TomObject p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, toElementRaw, [p0]) as dynamic; });
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce(($tom_core_kernel_19.TomObject p0, $tom_core_kernel_19.TomObject p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final growable = D4.getNamedArgWithDefault<bool>(named, 'growable', true);
        return t.toList(growable: growable);
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.toSet();
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'whereType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.whereType();
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'add');
        final value = D4.getRequiredArg<$tom_core_kernel_19.TomObject>(positional, 0, 'value', 'add');
        t.add(value);
        return null;
      },
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'addAll');
        final iterable = D4.getRequiredArg<Iterable<$tom_core_kernel_19.TomObject>>(positional, 0, 'iterable', 'addAll');
        t.addAll(iterable);
        return null;
      },
      'asMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.asMap();
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        t.clear();
        return null;
      },
      'fillRange': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 2, 'fillRange');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'fillRange');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'fillRange');
        final fillValue = D4.getOptionalArg<$tom_core_kernel_19.TomObject>(positional, 2, 'fillValue');
        t.fillRange(start, end, fillValue);
        return null;
      },
      'getRange': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 2, 'getRange');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'getRange');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'getRange');
        return t.getRange(start, end);
      },
      'indexOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'indexOf');
        final element = D4.getRequiredArg<$tom_core_kernel_19.TomObject>(positional, 0, 'element', 'indexOf');
        final start = D4.getOptionalArgWithDefault<int>(positional, 1, 'start', 0);
        return t.indexOf(element, start);
      },
      'indexWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'indexWhere');
        if (positional.isEmpty) {
          throw ArgumentError('indexWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final start = D4.getOptionalArgWithDefault<int>(positional, 1, 'start', 0);
        return t.indexWhere(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, start);
      },
      'insert': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 2, 'insert');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'insert');
        final element = D4.getRequiredArg<$tom_core_kernel_19.TomObject>(positional, 1, 'element', 'insert');
        t.insert(index, element);
        return null;
      },
      'insertAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 2, 'insertAll');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'insertAll');
        final iterable = D4.getRequiredArg<Iterable<$tom_core_kernel_19.TomObject>>(positional, 1, 'iterable', 'insertAll');
        t.insertAll(index, iterable);
        return null;
      },
      'lastIndexOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'lastIndexOf');
        final element = D4.getRequiredArg<$tom_core_kernel_19.TomObject>(positional, 0, 'element', 'lastIndexOf');
        final start = D4.getOptionalArg<int?>(positional, 1, 'start');
        return t.lastIndexOf(element, start);
      },
      'lastIndexWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'lastIndexWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastIndexWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final start = D4.getOptionalArg<int?>(positional, 1, 'start');
        return t.lastIndexWhere(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, start);
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'remove');
        final value = D4.getRequiredArg<Object?>(positional, 0, 'value', 'remove');
        return t.remove(value);
      },
      'removeAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'removeAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'removeAt');
        return t.removeAt(index);
      },
      'removeLast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return t.removeLast();
      },
      'removeRange': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 2, 'removeRange');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'removeRange');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'removeRange');
        t.removeRange(start, end);
        return null;
      },
      'removeWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'removeWhere');
        if (positional.isEmpty) {
          throw ArgumentError('removeWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        t.removeWhere(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
        return null;
      },
      'replaceRange': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 3, 'replaceRange');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'replaceRange');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'replaceRange');
        final replacements = D4.getRequiredArg<Iterable<$tom_core_kernel_19.TomObject>>(positional, 2, 'replacements', 'replaceRange');
        t.replaceRange(start, end, replacements);
        return null;
      },
      'retainWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'retainWhere');
        if (positional.isEmpty) {
          throw ArgumentError('retainWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        t.retainWhere(($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
        return null;
      },
      'setAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 2, 'setAll');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'setAll');
        final iterable = D4.getRequiredArg<Iterable<$tom_core_kernel_19.TomObject>>(positional, 1, 'iterable', 'setAll');
        t.setAll(index, iterable);
        return null;
      },
      'setRange': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 3, 'setRange');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'setRange');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'setRange');
        final iterable = D4.getRequiredArg<Iterable<$tom_core_kernel_19.TomObject>>(positional, 2, 'iterable', 'setRange');
        final skipCount = D4.getOptionalArgWithDefault<int>(positional, 3, 'skipCount', 0);
        t.setRange(start, end, iterable, skipCount);
        return null;
      },
      'shuffle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final random = D4.getOptionalArg<Random?>(positional, 0, 'random');
        t.shuffle(random);
        return null;
      },
      'sort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final compareRaw = positional.isNotEmpty ? positional[0] : null;
        t.sort(compareRaw == null ? null : ($tom_core_kernel_19.TomObject p0, $tom_core_kernel_19.TomObject p1) { return D4.callInterpreterCallback(visitor, compareRaw, [p0, p1]) as int; });
        return null;
      },
      'sublist': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        D4.requireMinArgs(positional, 1, 'sublist');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'sublist');
        final end = D4.getOptionalArg<int?>(positional, 1, 'end');
        return t.sublist(start, end);
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final other = D4.getRequiredArg<List<$tom_core_kernel_19.TomObject>>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final other = D4.getRequiredArg<List<$tom_core_kernel_19.TomObject>>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<$tom_core_kernel_19.TomObject>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final other = D4.getRequiredArg<$tom_core_kernel_19.TomList<$tom_core_kernel_19.TomObject>>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomList>(target, 'TomList');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'castFrom': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'castFrom');
        final source = D4.getRequiredArg<$tom_core_kernel_19.TomList<$tom_core_kernel_19.TomObject>>(positional, 0, 'source', 'castFrom');
        return $tom_core_kernel_19.TomList.castFrom(source);
      },
    },
    constructorSignatures: {
      '': 'TomList()',
      'from': 'TomList.from(TomList<E> existing)',
      'of': 'TomList.of(TomList<E> existing)',
      'ofList': 'TomList.ofList(List<E> list)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'List<E> get()',
      'set': 'List<E> set(List<E> value)',
      'getOrNull': 'List<E> getOrNull()',
      'call': 'List<E> call()',
      'toString': 'String toString()',
      'onNotify': 'void onNotify(TomObservable observable)',
      'append': 'TomList<E> append(E element)',
      'any': 'bool any(bool Function(E e) test)',
      'cast': 'List<R> cast()',
      'contains': 'bool contains(Object? o)',
      'elementAt': 'E elementAt(int index)',
      'every': 'bool every(bool Function(E e) test)',
      'expand': 'Iterable<R> expand(Iterable<R> Function(E e) toElements)',
      'firstWhere': 'E firstWhere(bool Function(E e) test, {dynamic Function()? orElse})',
      'fold': 'T fold(T initialValue, T Function(T previousValue, E element) combine)',
      'followedBy': 'Iterable<E> followedBy(Iterable<dynamic> other)',
      'forEach': 'void forEach(void Function(E element) action)',
      'join': 'String join([String separator = ""])',
      'lastWhere': 'E lastWhere(bool Function(E e) test, {dynamic Function()? orElse})',
      'map': 'Iterable<T> map(T Function(E e) toElement)',
      'reduce': 'E reduce(dynamic Function(E value, E element) combine)',
      'singleWhere': 'E singleWhere(bool Function(E e) test, {dynamic Function()? orElse})',
      'skip': 'Iterable<E> skip(int count)',
      'skipWhile': 'Iterable<E> skipWhile(bool Function(E value) test)',
      'take': 'Iterable<E> take(int count)',
      'takeWhile': 'Iterable<E> takeWhile(bool Function(E value) test)',
      'toList': 'List<E> toList({bool growable = true})',
      'toSet': 'Set<E> toSet()',
      'where': 'Iterable<E> where(bool Function(E element) test)',
      'whereType': 'Iterable<T> whereType()',
      'add': 'void add(E value)',
      'addAll': 'void addAll(Iterable<E> iterable)',
      'asMap': 'Map<int, E> asMap()',
      'clear': 'void clear()',
      'fillRange': 'void fillRange(int start, int end, [E? fillValue])',
      'getRange': 'Iterable<E> getRange(int start, int end)',
      'indexOf': 'int indexOf(E element, [int start = 0])',
      'indexWhere': 'int indexWhere(bool Function(E element) test, [int start = 0])',
      'insert': 'void insert(int index, E element)',
      'insertAll': 'void insertAll(int index, Iterable<E> iterable)',
      'lastIndexOf': 'int lastIndexOf(E element, [int? start])',
      'lastIndexWhere': 'int lastIndexWhere(bool Function(E element) test, [int? start])',
      'remove': 'bool remove(Object? value)',
      'removeAt': 'E removeAt(int index)',
      'removeLast': 'E removeLast()',
      'removeRange': 'void removeRange(int start, int end)',
      'removeWhere': 'void removeWhere(bool Function(E element) test)',
      'replaceRange': 'void replaceRange(int start, int end, Iterable<E> replacements)',
      'retainWhere': 'void retainWhere(bool Function(E element) test)',
      'setAll': 'void setAll(int index, Iterable<E> iterable)',
      'setRange': 'void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])',
      'shuffle': 'void shuffle([Random? random])',
      'sort': 'void sort([int Function(E a, E b)? compare])',
      'sublist': 'List<E> sublist(int start, [int? end])',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
      'first': 'E get first',
      'last': 'E get last',
      'length': 'int get length',
      'reversed': 'Iterable<E> get reversed',
      'hashCode': 'int get hashCode',
      'isEmpty': 'bool get isEmpty',
      'isNotEmpty': 'bool get isNotEmpty',
      'iterator': 'Iterator<E> get iterator',
      'single': 'E get single',
    },
    setterSignatures: {
      'first': 'set first(E value)',
      'last': 'set last(E value)',
      'length': 'set length(int value)',
    },
    staticMethodSignatures: {
      'castFrom': 'TomList<E> castFrom(TomList<S> source)',
    },
  );
}

// =============================================================================
// TomMap Bridge
// =============================================================================

BridgedClass _createTomMapBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_19.TomMap,
    name: 'TomMap',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_core_kernel_19.TomMap();
      },
      'from': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomMap');
        final existing = D4.getRequiredArg<$tom_core_kernel_19.TomMap<dynamic, $tom_core_kernel_19.TomObject>>(positional, 0, 'existing', 'TomMap');
        return $tom_core_kernel_19.TomMap.from(existing);
      },
      'of': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomMap');
        final existing = D4.getRequiredArg<$tom_core_kernel_19.TomMap<dynamic, $tom_core_kernel_19.TomObject>>(positional, 0, 'existing', 'TomMap');
        return $tom_core_kernel_19.TomMap.of(existing);
      },
      'ofMap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomMap');
        if (positional.isEmpty) {
          throw ArgumentError('TomMap: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<dynamic, $tom_core_kernel_19.TomObject>(positional[0], 'map');
        return $tom_core_kernel_19.TomMap.ofMap(map);
      },
    },
    getters: {
      'isMuted': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap').isMuted,
      'isNull': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap').isNull,
      'length': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap').length,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap').hashCode,
      'isEmpty': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap').isNotEmpty,
      'keys': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap').keys,
      'values': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap').values,
      'entries': (visitor, target) => D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap').entries,
    },
    methods: {
      'mute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        t.mute();
        return null;
      },
      'unmute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        t.unmute();
        return null;
      },
      'addObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'addObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'addObserver');
        t.addObserver(observer);
        return null;
      },
      'removeObserver': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'removeObserver');
        final observer = D4.getRequiredArg<$tom_core_kernel_18.TomObserver<$tom_core_kernel_18.TomObservable>>(positional, 0, 'observer', 'removeObserver');
        t.removeObserver(observer);
        return null;
      },
      'notifyObservers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        final message = D4.getOptionalArg<dynamic>(positional, 0, 'message');
        t.notifyObservers(message);
        return null;
      },
      'getType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        return t.getType();
      },
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        return t.get();
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'set');
        if (positional.isEmpty) {
          throw ArgumentError('set: Missing required argument "value" at position 0');
        }
        final value = D4.coerceMap<dynamic, $tom_core_kernel_19.TomObject>(positional[0], 'value');
        return t.set(value);
      },
      'getOrNull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        return t.getOrNull();
      },
      'call': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        return t.call();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        return t.toString();
      },
      'onNotify': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'onNotify');
        final observable = D4.getRequiredArg<$tom_core_kernel_18.TomObservable>(positional, 0, 'observable', 'onNotify');
        t.onNotify(observable);
        return null;
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 2, 'add');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'add');
        final value = D4.getRequiredArg<$tom_core_kernel_19.TomObject>(positional, 1, 'value', 'add');
        t.add(key, value);
        return null;
      },
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'addAll');
        if (positional.isEmpty) {
          throw ArgumentError('addAll: Missing required argument "other" at position 0');
        }
        final other = D4.coerceMap<dynamic, $tom_core_kernel_19.TomObject>(positional[0], 'other');
        t.addAll(other);
        return null;
      },
      'addEntries': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'addEntries');
        final newEntries = D4.getRequiredArg<Iterable<MapEntry<dynamic, $tom_core_kernel_19.TomObject>>>(positional, 0, 'newEntries', 'addEntries');
        t.addEntries(newEntries);
        return null;
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        return t.cast();
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        t.clear();
        return null;
      },
      'containsKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'containsKey');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'containsKey');
        return t.containsKey(key);
      },
      'containsValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'containsValue');
        final value = D4.getRequiredArg<$tom_core_kernel_19.TomObject>(positional, 0, 'value', 'containsValue');
        return t.containsValue(value);
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0, $tom_core_kernel_19.TomObject p1) { D4.callInterpreterCallback(visitor, actionRaw, [p0, p1]); });
        return null;
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "convert" at position 0');
        }
        final convertRaw = positional[0];
        return t.map((dynamic p0, $tom_core_kernel_19.TomObject p1) { return D4.callInterpreterCallback(visitor, convertRaw, [p0, p1]) as MapEntry<dynamic, dynamic>; });
      },
      'putIfAbsent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 2, 'putIfAbsent');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'putIfAbsent');
        if (positional.length <= 1) {
          throw ArgumentError('putIfAbsent: Missing required argument "ifAbsent" at position 1');
        }
        final ifAbsentRaw = positional[1];
        return t.putIfAbsent(key, () { return D4.callInterpreterCallback(visitor, ifAbsentRaw, []) as $tom_core_kernel_19.TomObject; });
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'remove');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'remove');
        return t.remove(key);
      },
      'removeWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'removeWhere');
        if (positional.isEmpty) {
          throw ArgumentError('removeWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        t.removeWhere((dynamic p0, $tom_core_kernel_19.TomObject p1) { return D4.callInterpreterCallback(visitor, testRaw, [p0, p1]) as bool; });
        return null;
      },
      'update': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 2, 'update');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'update');
        if (positional.length <= 1) {
          throw ArgumentError('update: Missing required argument "update" at position 1');
        }
        final updateRaw = positional[1];
        final ifAbsentRaw = named['ifAbsent'];
        return t.update(key, ($tom_core_kernel_19.TomObject p0) { return D4.callInterpreterCallback(visitor, updateRaw, [p0]) as $tom_core_kernel_19.TomObject; }, ifAbsent: ifAbsentRaw == null ? null : () { return D4.callInterpreterCallback(visitor, ifAbsentRaw, []) as $tom_core_kernel_19.TomObject; });
      },
      'updateAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        D4.requireMinArgs(positional, 1, 'updateAll');
        if (positional.isEmpty) {
          throw ArgumentError('updateAll: Missing required argument "update" at position 0');
        }
        final updateRaw = positional[0];
        t.updateAll((dynamic p0, $tom_core_kernel_19.TomObject p1) { return D4.callInterpreterCallback(visitor, updateRaw, [p0, p1]) as $tom_core_kernel_19.TomObject; });
        return null;
      },
      '>>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        final other = D4.getRequiredArg<void Function($tom_core_kernel_18.TomObservable)>(positional, 0, 'other', 'operator>>');
        return t >> other;
      },
      '~': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        return ~t;
      },
      '|': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        final other = D4.getRequiredArg<Map<dynamic, $tom_core_kernel_19.TomObject>>(positional, 0, 'other', 'operator|');
        return t | other;
      },
      '<<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        final other = D4.getRequiredArg<Map<dynamic, $tom_core_kernel_19.TomObject>>(positional, 0, 'other', 'operator<<');
        return t << other;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<$tom_core_kernel_19.TomObject>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        final other = D4.getRequiredArg<$tom_core_kernel_19.TomMap<dynamic, $tom_core_kernel_19.TomObject>>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_19.TomMap>(target, 'TomMap');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'castFrom': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'castFrom');
        final source = D4.getRequiredArg<$tom_core_kernel_19.TomMap<dynamic, $tom_core_kernel_19.TomObject>>(positional, 0, 'source', 'castFrom');
        return $tom_core_kernel_19.TomMap.castFrom(source);
      },
    },
    constructorSignatures: {
      '': 'TomMap()',
      'from': 'TomMap.from(TomMap<K, V> existing)',
      'of': 'TomMap.of(TomMap<K, V> existing)',
      'ofMap': 'TomMap.ofMap(Map<K, V> map)',
    },
    methodSignatures: {
      'mute': 'void mute()',
      'unmute': 'void unmute()',
      'addObserver': 'void addObserver(TomObserver<TomObservable> observer)',
      'removeObserver': 'void removeObserver(TomObserver<TomObservable> observer)',
      'notifyObservers': 'void notifyObservers([dynamic message])',
      'getType': 'Type getType()',
      'get': 'Map<K, V> get()',
      'set': 'Map<K, V> set(Map<K, V> value)',
      'getOrNull': 'Map<K, V> getOrNull()',
      'call': 'Map<K, V> call()',
      'toString': 'String toString()',
      'onNotify': 'void onNotify(TomObservable observable)',
      'add': 'void add(K key, V value)',
      'addAll': 'void addAll(Map<K, V> other)',
      'addEntries': 'void addEntries(Iterable<MapEntry<K, V>> newEntries)',
      'cast': 'Map<RK, RV> cast()',
      'clear': 'void clear()',
      'containsKey': 'bool containsKey(K key)',
      'containsValue': 'bool containsValue(V value)',
      'forEach': 'void forEach(void Function(K key, V value) action)',
      'map': 'Map<K2, V2> map(MapEntry<K2, V2> Function(K key, V value) convert)',
      'putIfAbsent': 'V putIfAbsent(K key, V Function() ifAbsent)',
      'remove': 'V? remove(K? key)',
      'removeWhere': 'void removeWhere(bool Function(K key, V value) test)',
      'update': 'V update(K key, V Function(V value) update, {V Function()? ifAbsent})',
      'updateAll': 'void updateAll(V Function(K key, V value) update)',
    },
    getterSignatures: {
      'isMuted': 'bool get isMuted',
      'isNull': 'bool get isNull',
      'length': 'int get length',
      'hashCode': 'int get hashCode',
      'isEmpty': 'bool get isEmpty',
      'isNotEmpty': 'bool get isNotEmpty',
      'keys': 'Iterable<K> get keys',
      'values': 'Iterable<V> get values',
      'entries': 'Iterable<MapEntry<K, V>> get entries',
    },
    staticMethodSignatures: {
      'castFrom': 'TomMap<K2, V2> castFrom(TomMap<K, V> source)',
    },
  );
}

// =============================================================================
// TomTimezoned Bridge
// =============================================================================

BridgedClass _createTomTimezonedBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_28.TomTimezoned,
    name: 'TomTimezoned',
    constructors: {
      '': (visitor, positional, named) {
        final year = D4.getRequiredNamedArg<int>(named, 'year', 'TomTimezoned');
        final month = D4.getNamedArgWithDefault<int>(named, 'month', 1);
        final day = D4.getNamedArgWithDefault<int>(named, 'day', 1);
        final hour = D4.getNamedArgWithDefault<int>(named, 'hour', 0);
        final minute = D4.getNamedArgWithDefault<int>(named, 'minute', 0);
        final second = D4.getNamedArgWithDefault<int>(named, 'second', 0);
        final millisecond = D4.getNamedArgWithDefault<int>(named, 'millisecond', 0);
        final microsecond = D4.getNamedArgWithDefault<int>(named, 'microsecond', 0);
        final timezone = D4.getOptionalNamedArg<$tom_core_kernel_29.TomTimezone?>(named, 'timezone');
        return $tom_core_kernel_28.TomTimezoned(year: year, month: month, day: day, hour: hour, minute: minute, second: second, millisecond: millisecond, microsecond: microsecond, timezone: timezone);
      },
      'utc': (visitor, positional, named) {
        final year = D4.getNamedArgWithDefault<int>(named, 'year', 1970);
        final month = D4.getNamedArgWithDefault<int>(named, 'month', 1);
        final day = D4.getNamedArgWithDefault<int>(named, 'day', 1);
        final hour = D4.getNamedArgWithDefault<int>(named, 'hour', 0);
        final minute = D4.getNamedArgWithDefault<int>(named, 'minute', 0);
        final second = D4.getNamedArgWithDefault<int>(named, 'second', 0);
        final millisecond = D4.getNamedArgWithDefault<int>(named, 'millisecond', 0);
        final microsecond = D4.getNamedArgWithDefault<int>(named, 'microsecond', 0);
        return $tom_core_kernel_28.TomTimezoned.utc(year: year, month: month, day: day, hour: hour, minute: minute, second: second, millisecond: millisecond, microsecond: microsecond);
      },
      'now': (visitor, positional, named) {
        final timezone = D4.getOptionalArg<$tom_core_kernel_29.TomTimezone?>(positional, 0, 'timezone');
        return $tom_core_kernel_28.TomTimezoned.now(timezone);
      },
      'fromDateTime': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomTimezoned');
        final dateTime = D4.getRequiredArg<DateTime>(positional, 0, 'dateTime', 'TomTimezoned');
        final timezone = D4.getOptionalArg<$tom_core_kernel_29.TomTimezone?>(positional, 1, 'timezone');
        return $tom_core_kernel_28.TomTimezoned.fromDateTime(dateTime, timezone);
      },
      'parseFromString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomTimezoned');
        final formattedString = D4.getRequiredArg<String>(positional, 0, 'formattedString', 'TomTimezoned');
        return $tom_core_kernel_28.TomTimezoned.parseFromString(formattedString);
      },
    },
    getters: {
      'timezone': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').timezone,
      'localYear': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').localYear,
      'localMonth': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').localMonth,
      'localDay': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').localDay,
      'localHour': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').localHour,
      'localMinute': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').localMinute,
      'localSecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').localSecond,
      'localMillisecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').localMillisecond,
      'localMicrosecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').localMicrosecond,
      'localWeekday': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').localWeekday,
      'isUtc': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').isUtc,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').hashCode,
      'millisecondsSinceEpoch': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').millisecondsSinceEpoch,
      'microsecondsSinceEpoch': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').microsecondsSinceEpoch,
      'timeZoneName': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').timeZoneName,
      'timeZoneOffset': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').timeZoneOffset,
      'year': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').year,
      'month': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').month,
      'day': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').day,
      'hour': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').hour,
      'minute': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').minute,
      'second': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').second,
      'millisecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').millisecond,
      'microsecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').microsecond,
      'weekday': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned').weekday,
    },
    methods: {
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        return t.getSerializationPrefix();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        return t.toString();
      },
      'toDateTime': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        return t.toDateTime();
      },
      'isBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        D4.requireMinArgs(positional, 1, 'isBefore');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isBefore');
        return t.isBefore(other);
      },
      'isAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        D4.requireMinArgs(positional, 1, 'isAfter');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isAfter');
        return t.isAfter(other);
      },
      'isAtSameMomentAs': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        D4.requireMinArgs(positional, 1, 'isAtSameMomentAs');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isAtSameMomentAs');
        return t.isAtSameMomentAs(other);
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toLocal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        return t.toLocal();
      },
      'toUtc': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        return t.toUtc();
      },
      'toIso8601String': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        return t.toIso8601String();
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        D4.requireMinArgs(positional, 1, 'add');
        final duration = D4.getRequiredArg<Duration>(positional, 0, 'duration', 'add');
        return t.add(duration);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        D4.requireMinArgs(positional, 1, 'subtract');
        final duration = D4.getRequiredArg<Duration>(positional, 0, 'duration', 'subtract');
        return t.subtract(duration);
      },
      'difference': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        D4.requireMinArgs(positional, 1, 'difference');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'difference');
        return t.difference(other);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomTimezoned>(target, 'TomTimezoned');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'isTomTimezonedString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isTomTimezonedString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'isTomTimezonedString');
        return $tom_core_kernel_28.TomTimezoned.isTomTimezonedString(s);
      },
    },
    constructorSignatures: {
      '': 'factory TomTimezoned({required int year, int month = 1, int day = 1, int hour = 0, int minute = 0, int second = 0, int millisecond = 0, int microsecond = 0, TomTimezone? timezone})',
      'utc': 'TomTimezoned.utc({int year = 1970, int month = 1, int day = 1, int hour = 0, int minute = 0, int second = 0, int millisecond = 0, int microsecond = 0})',
      'now': 'factory TomTimezoned.now([TomTimezone? timezone])',
      'fromDateTime': 'factory TomTimezoned.fromDateTime(DateTime dateTime, [TomTimezone? timezone])',
      'parseFromString': 'factory TomTimezoned.parseFromString(String formattedString)',
    },
    methodSignatures: {
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'toString': 'String toString()',
      'toDateTime': 'DateTime toDateTime()',
      'isBefore': 'bool isBefore(DateTime other)',
      'isAfter': 'bool isAfter(DateTime other)',
      'isAtSameMomentAs': 'bool isAtSameMomentAs(DateTime other)',
      'compareTo': 'int compareTo(DateTime other)',
      'toLocal': 'DateTime toLocal()',
      'toUtc': 'DateTime toUtc()',
      'toIso8601String': 'String toIso8601String()',
      'add': 'DateTime add(Duration duration)',
      'subtract': 'DateTime subtract(Duration duration)',
      'difference': 'Duration difference(DateTime other)',
    },
    getterSignatures: {
      'timezone': 'TomTimezone get timezone',
      'localYear': 'int get localYear',
      'localMonth': 'int get localMonth',
      'localDay': 'int get localDay',
      'localHour': 'int get localHour',
      'localMinute': 'int get localMinute',
      'localSecond': 'int get localSecond',
      'localMillisecond': 'int get localMillisecond',
      'localMicrosecond': 'int get localMicrosecond',
      'localWeekday': 'int get localWeekday',
      'isUtc': 'bool get isUtc',
      'hashCode': 'int get hashCode',
      'millisecondsSinceEpoch': 'int get millisecondsSinceEpoch',
      'microsecondsSinceEpoch': 'int get microsecondsSinceEpoch',
      'timeZoneName': 'String get timeZoneName',
      'timeZoneOffset': 'Duration get timeZoneOffset',
      'year': 'int get year',
      'month': 'int get month',
      'day': 'int get day',
      'hour': 'int get hour',
      'minute': 'int get minute',
      'second': 'int get second',
      'millisecond': 'int get millisecond',
      'microsecond': 'int get microsecond',
      'weekday': 'int get weekday',
    },
    staticMethodSignatures: {
      'isTomTimezonedString': 'bool isTomTimezonedString(String s)',
    },
  );
}

// =============================================================================
// TomZonedDate Bridge
// =============================================================================

BridgedClass _createTomZonedDateBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_28.TomZonedDate,
    name: 'TomZonedDate',
    constructors: {
      '': (visitor, positional, named) {
        final year = D4.getNamedArgWithDefault<int>(named, 'year', 1970);
        final month = D4.getNamedArgWithDefault<int>(named, 'month', 1);
        final day = D4.getNamedArgWithDefault<int>(named, 'day', 1);
        final timezone = D4.getOptionalNamedArg<$tom_core_kernel_29.TomTimezone?>(named, 'timezone');
        return $tom_core_kernel_28.TomZonedDate(year: year, month: month, day: day, timezone: timezone);
      },
      'fromDateTime': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomZonedDate');
        final dtx = D4.getRequiredArg<DateTime>(positional, 0, 'dtx', 'TomZonedDate');
        final timezone = D4.getOptionalArg<$tom_core_kernel_29.TomTimezone?>(positional, 1, 'timezone');
        return $tom_core_kernel_28.TomZonedDate.fromDateTime(dtx, timezone);
      },
      'parseFromString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomZonedDate');
        final formattedString = D4.getRequiredArg<String>(positional, 0, 'formattedString', 'TomZonedDate');
        return $tom_core_kernel_28.TomZonedDate.parseFromString(formattedString);
      },
    },
    getters: {
      'timezone': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').timezone,
      'localYear': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').localYear,
      'localMonth': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').localMonth,
      'localDay': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').localDay,
      'localHour': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').localHour,
      'localMinute': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').localMinute,
      'localSecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').localSecond,
      'localMillisecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').localMillisecond,
      'localMicrosecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').localMicrosecond,
      'localWeekday': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').localWeekday,
      'isUtc': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').isUtc,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').hashCode,
      'millisecondsSinceEpoch': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').millisecondsSinceEpoch,
      'microsecondsSinceEpoch': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').microsecondsSinceEpoch,
      'timeZoneName': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').timeZoneName,
      'timeZoneOffset': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').timeZoneOffset,
      'year': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').year,
      'month': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').month,
      'day': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').day,
      'hour': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').hour,
      'minute': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').minute,
      'second': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').second,
      'millisecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').millisecond,
      'microsecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').microsecond,
      'weekday': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate').weekday,
    },
    methods: {
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        return t.getSerializationPrefix();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        return t.toString();
      },
      'toDateTime': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        return t.toDateTime();
      },
      'isBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        D4.requireMinArgs(positional, 1, 'isBefore');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isBefore');
        return t.isBefore(other);
      },
      'isAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        D4.requireMinArgs(positional, 1, 'isAfter');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isAfter');
        return t.isAfter(other);
      },
      'isAtSameMomentAs': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        D4.requireMinArgs(positional, 1, 'isAtSameMomentAs');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isAtSameMomentAs');
        return t.isAtSameMomentAs(other);
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toLocal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        return t.toLocal();
      },
      'toUtc': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        return t.toUtc();
      },
      'toIso8601String': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        return t.toIso8601String();
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        D4.requireMinArgs(positional, 1, 'add');
        final duration = D4.getRequiredArg<Duration>(positional, 0, 'duration', 'add');
        return t.add(duration);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        D4.requireMinArgs(positional, 1, 'subtract');
        final duration = D4.getRequiredArg<Duration>(positional, 0, 'duration', 'subtract');
        return t.subtract(duration);
      },
      'difference': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        D4.requireMinArgs(positional, 1, 'difference');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'difference');
        return t.difference(other);
      },
      'convertToTimezone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        D4.requireMinArgs(positional, 1, 'convertToTimezone');
        final targetTimezone = D4.getRequiredArg<$tom_core_kernel_29.TomTimezone>(positional, 0, 'targetTimezone', 'convertToTimezone');
        return t.convertToTimezone(targetTimezone);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDate>(target, 'TomZonedDate');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'serializationPrefix': (visitor) => $tom_core_kernel_28.TomZonedDate.serializationPrefix,
    },
    staticMethods: {
      'isTomZonedDateString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isTomZonedDateString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'isTomZonedDateString');
        return $tom_core_kernel_28.TomZonedDate.isTomZonedDateString(s);
      },
      'isDate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isDate');
        final dt = D4.getRequiredArg<DateTime>(positional, 0, 'dt', 'isDate');
        return $tom_core_kernel_28.TomZonedDate.isDate(dt);
      },
    },
    constructorSignatures: {
      '': 'factory TomZonedDate({int year = 1970, int month = 1, int day = 1, TomTimezone? timezone})',
      'fromDateTime': 'factory TomZonedDate.fromDateTime(DateTime dtx, [TomTimezone? timezone])',
      'parseFromString': 'factory TomZonedDate.parseFromString(String formattedString)',
    },
    methodSignatures: {
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'toString': 'String toString()',
      'toDateTime': 'DateTime toDateTime()',
      'isBefore': 'bool isBefore(DateTime other)',
      'isAfter': 'bool isAfter(DateTime other)',
      'isAtSameMomentAs': 'bool isAtSameMomentAs(DateTime other)',
      'compareTo': 'int compareTo(DateTime other)',
      'toLocal': 'DateTime toLocal()',
      'toUtc': 'DateTime toUtc()',
      'toIso8601String': 'String toIso8601String()',
      'add': 'DateTime add(Duration duration)',
      'subtract': 'DateTime subtract(Duration duration)',
      'difference': 'Duration difference(DateTime other)',
      'convertToTimezone': 'TomZonedDate convertToTimezone(TomTimezone targetTimezone)',
    },
    getterSignatures: {
      'timezone': 'TomTimezone get timezone',
      'localYear': 'int get localYear',
      'localMonth': 'int get localMonth',
      'localDay': 'int get localDay',
      'localHour': 'int get localHour',
      'localMinute': 'int get localMinute',
      'localSecond': 'int get localSecond',
      'localMillisecond': 'int get localMillisecond',
      'localMicrosecond': 'int get localMicrosecond',
      'localWeekday': 'int get localWeekday',
      'isUtc': 'bool get isUtc',
      'hashCode': 'int get hashCode',
      'millisecondsSinceEpoch': 'int get millisecondsSinceEpoch',
      'microsecondsSinceEpoch': 'int get microsecondsSinceEpoch',
      'timeZoneName': 'String get timeZoneName',
      'timeZoneOffset': 'Duration get timeZoneOffset',
      'year': 'int get year',
      'month': 'int get month',
      'day': 'int get day',
      'hour': 'int get hour',
      'minute': 'int get minute',
      'second': 'int get second',
      'millisecond': 'int get millisecond',
      'microsecond': 'int get microsecond',
      'weekday': 'int get weekday',
    },
    staticMethodSignatures: {
      'isTomZonedDateString': 'bool isTomZonedDateString(String s)',
      'isDate': 'bool isDate(DateTime dt)',
    },
    staticGetterSignatures: {
      'serializationPrefix': 'String get serializationPrefix',
    },
  );
}

// =============================================================================
// TomZonedTime Bridge
// =============================================================================

BridgedClass _createTomZonedTimeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_28.TomZonedTime,
    name: 'TomZonedTime',
    constructors: {
      '': (visitor, positional, named) {
        final hour = D4.getNamedArgWithDefault<int>(named, 'hour', 0);
        final minute = D4.getNamedArgWithDefault<int>(named, 'minute', 0);
        final second = D4.getNamedArgWithDefault<int>(named, 'second', 0);
        final millisecond = D4.getNamedArgWithDefault<int>(named, 'millisecond', 0);
        final microsecond = D4.getNamedArgWithDefault<int>(named, 'microsecond', 0);
        final timezone = D4.getOptionalNamedArg<$tom_core_kernel_29.TomTimezone?>(named, 'timezone');
        return $tom_core_kernel_28.TomZonedTime(hour: hour, minute: minute, second: second, millisecond: millisecond, microsecond: microsecond, timezone: timezone);
      },
      'fromDateTime': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomZonedTime');
        final dtx = D4.getRequiredArg<DateTime>(positional, 0, 'dtx', 'TomZonedTime');
        final timezone = D4.getOptionalArg<$tom_core_kernel_29.TomTimezone?>(positional, 1, 'timezone');
        return $tom_core_kernel_28.TomZonedTime.fromDateTime(dtx, timezone);
      },
      'parseFromString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomZonedTime');
        final formattedString = D4.getRequiredArg<String>(positional, 0, 'formattedString', 'TomZonedTime');
        return $tom_core_kernel_28.TomZonedTime.parseFromString(formattedString);
      },
    },
    getters: {
      'timezone': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').timezone,
      'localYear': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').localYear,
      'localMonth': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').localMonth,
      'localDay': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').localDay,
      'localHour': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').localHour,
      'localMinute': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').localMinute,
      'localSecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').localSecond,
      'localMillisecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').localMillisecond,
      'localMicrosecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').localMicrosecond,
      'localWeekday': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').localWeekday,
      'isUtc': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').isUtc,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').hashCode,
      'millisecondsSinceEpoch': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').millisecondsSinceEpoch,
      'microsecondsSinceEpoch': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').microsecondsSinceEpoch,
      'timeZoneName': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').timeZoneName,
      'timeZoneOffset': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').timeZoneOffset,
      'year': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').year,
      'month': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').month,
      'day': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').day,
      'hour': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').hour,
      'minute': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').minute,
      'second': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').second,
      'millisecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').millisecond,
      'microsecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').microsecond,
      'weekday': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime').weekday,
    },
    methods: {
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        return t.getSerializationPrefix();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        return t.toString();
      },
      'toDateTime': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        return t.toDateTime();
      },
      'isBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        D4.requireMinArgs(positional, 1, 'isBefore');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isBefore');
        return t.isBefore(other);
      },
      'isAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        D4.requireMinArgs(positional, 1, 'isAfter');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isAfter');
        return t.isAfter(other);
      },
      'isAtSameMomentAs': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        D4.requireMinArgs(positional, 1, 'isAtSameMomentAs');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isAtSameMomentAs');
        return t.isAtSameMomentAs(other);
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toLocal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        return t.toLocal();
      },
      'toUtc': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        return t.toUtc();
      },
      'toIso8601String': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        return t.toIso8601String();
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        D4.requireMinArgs(positional, 1, 'add');
        final duration = D4.getRequiredArg<Duration>(positional, 0, 'duration', 'add');
        return t.add(duration);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        D4.requireMinArgs(positional, 1, 'subtract');
        final duration = D4.getRequiredArg<Duration>(positional, 0, 'duration', 'subtract');
        return t.subtract(duration);
      },
      'difference': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        D4.requireMinArgs(positional, 1, 'difference');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'difference');
        return t.difference(other);
      },
      'convertToTimezone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        D4.requireMinArgs(positional, 1, 'convertToTimezone');
        final targetTimezone = D4.getRequiredArg<$tom_core_kernel_29.TomTimezone>(positional, 0, 'targetTimezone', 'convertToTimezone');
        return t.convertToTimezone(targetTimezone);
      },
      'inTimezoneOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        D4.requireMinArgs(positional, 1, 'inTimezoneOn');
        final when = D4.getRequiredArg<DateTime>(positional, 0, 'when', 'inTimezoneOn');
        return t.inTimezoneOn(when);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedTime>(target, 'TomZonedTime');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'serializationPrefix': (visitor) => $tom_core_kernel_28.TomZonedTime.serializationPrefix,
    },
    staticMethods: {
      'isTomZonedTimeString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isTomZonedTimeString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'isTomZonedTimeString');
        return $tom_core_kernel_28.TomZonedTime.isTomZonedTimeString(s);
      },
      'isTime': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isTime');
        final dt = D4.getRequiredArg<DateTime>(positional, 0, 'dt', 'isTime');
        return $tom_core_kernel_28.TomZonedTime.isTime(dt);
      },
    },
    constructorSignatures: {
      '': 'factory TomZonedTime({int hour = 0, int minute = 0, int second = 0, int millisecond = 0, int microsecond = 0, TomTimezone? timezone})',
      'fromDateTime': 'factory TomZonedTime.fromDateTime(DateTime dtx, [TomTimezone? timezone])',
      'parseFromString': 'factory TomZonedTime.parseFromString(String formattedString)',
    },
    methodSignatures: {
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'toString': 'String toString()',
      'toDateTime': 'DateTime toDateTime()',
      'isBefore': 'bool isBefore(DateTime other)',
      'isAfter': 'bool isAfter(DateTime other)',
      'isAtSameMomentAs': 'bool isAtSameMomentAs(DateTime other)',
      'compareTo': 'int compareTo(DateTime other)',
      'toLocal': 'DateTime toLocal()',
      'toUtc': 'DateTime toUtc()',
      'toIso8601String': 'String toIso8601String()',
      'add': 'DateTime add(Duration duration)',
      'subtract': 'DateTime subtract(Duration duration)',
      'difference': 'Duration difference(DateTime other)',
      'convertToTimezone': 'TomZonedTime convertToTimezone(TomTimezone targetTimezone)',
      'inTimezoneOn': 'DateTime inTimezoneOn(DateTime when)',
    },
    getterSignatures: {
      'timezone': 'TomTimezone get timezone',
      'localYear': 'int get localYear',
      'localMonth': 'int get localMonth',
      'localDay': 'int get localDay',
      'localHour': 'int get localHour',
      'localMinute': 'int get localMinute',
      'localSecond': 'int get localSecond',
      'localMillisecond': 'int get localMillisecond',
      'localMicrosecond': 'int get localMicrosecond',
      'localWeekday': 'int get localWeekday',
      'isUtc': 'bool get isUtc',
      'hashCode': 'int get hashCode',
      'millisecondsSinceEpoch': 'int get millisecondsSinceEpoch',
      'microsecondsSinceEpoch': 'int get microsecondsSinceEpoch',
      'timeZoneName': 'String get timeZoneName',
      'timeZoneOffset': 'Duration get timeZoneOffset',
      'year': 'int get year',
      'month': 'int get month',
      'day': 'int get day',
      'hour': 'int get hour',
      'minute': 'int get minute',
      'second': 'int get second',
      'millisecond': 'int get millisecond',
      'microsecond': 'int get microsecond',
      'weekday': 'int get weekday',
    },
    staticMethodSignatures: {
      'isTomZonedTimeString': 'bool isTomZonedTimeString(String s)',
      'isTime': 'bool isTime(DateTime dt)',
    },
    staticGetterSignatures: {
      'serializationPrefix': 'String get serializationPrefix',
    },
  );
}

// =============================================================================
// TomZonedDateTime Bridge
// =============================================================================

BridgedClass _createTomZonedDateTimeBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_28.TomZonedDateTime,
    name: 'TomZonedDateTime',
    constructors: {
      '': (visitor, positional, named) {
        final year = D4.getNamedArgWithDefault<int>(named, 'year', 1970);
        final month = D4.getNamedArgWithDefault<int>(named, 'month', 1);
        final day = D4.getNamedArgWithDefault<int>(named, 'day', 1);
        final hour = D4.getNamedArgWithDefault<int>(named, 'hour', 0);
        final minute = D4.getNamedArgWithDefault<int>(named, 'minute', 0);
        final second = D4.getNamedArgWithDefault<int>(named, 'second', 0);
        final millisecond = D4.getNamedArgWithDefault<int>(named, 'millisecond', 0);
        final microsecond = D4.getNamedArgWithDefault<int>(named, 'microsecond', 0);
        final timezone = D4.getOptionalNamedArg<$tom_core_kernel_29.TomTimezone?>(named, 'timezone');
        return $tom_core_kernel_28.TomZonedDateTime(year: year, month: month, day: day, hour: hour, minute: minute, second: second, millisecond: millisecond, microsecond: microsecond, timezone: timezone);
      },
      'fromDateTime': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomZonedDateTime');
        final dtx = D4.getRequiredArg<DateTime>(positional, 0, 'dtx', 'TomZonedDateTime');
        final timezone = D4.getOptionalArg<$tom_core_kernel_29.TomTimezone?>(positional, 1, 'timezone');
        return $tom_core_kernel_28.TomZonedDateTime.fromDateTime(dtx, timezone);
      },
      'parseFromString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomZonedDateTime');
        final formattedString = D4.getRequiredArg<String>(positional, 0, 'formattedString', 'TomZonedDateTime');
        return $tom_core_kernel_28.TomZonedDateTime.parseFromString(formattedString);
      },
    },
    getters: {
      'timezone': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').timezone,
      'localYear': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').localYear,
      'localMonth': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').localMonth,
      'localDay': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').localDay,
      'localHour': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').localHour,
      'localMinute': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').localMinute,
      'localSecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').localSecond,
      'localMillisecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').localMillisecond,
      'localMicrosecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').localMicrosecond,
      'localWeekday': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').localWeekday,
      'isUtc': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').isUtc,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').hashCode,
      'millisecondsSinceEpoch': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').millisecondsSinceEpoch,
      'microsecondsSinceEpoch': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').microsecondsSinceEpoch,
      'timeZoneName': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').timeZoneName,
      'timeZoneOffset': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').timeZoneOffset,
      'year': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').year,
      'month': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').month,
      'day': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').day,
      'hour': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').hour,
      'minute': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').minute,
      'second': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').second,
      'millisecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').millisecond,
      'microsecond': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').microsecond,
      'weekday': (visitor, target) => D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime').weekday,
    },
    methods: {
      'getSerializationPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        return t.getSerializationPrefix();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        return t.toString();
      },
      'toDateTime': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        return t.toDateTime();
      },
      'isBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        D4.requireMinArgs(positional, 1, 'isBefore');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isBefore');
        return t.isBefore(other);
      },
      'isAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        D4.requireMinArgs(positional, 1, 'isAfter');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isAfter');
        return t.isAfter(other);
      },
      'isAtSameMomentAs': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        D4.requireMinArgs(positional, 1, 'isAtSameMomentAs');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'isAtSameMomentAs');
        return t.isAtSameMomentAs(other);
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toLocal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        return t.toLocal();
      },
      'toUtc': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        return t.toUtc();
      },
      'toIso8601String': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        return t.toIso8601String();
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        D4.requireMinArgs(positional, 1, 'add');
        final duration = D4.getRequiredArg<Duration>(positional, 0, 'duration', 'add');
        return t.add(duration);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        D4.requireMinArgs(positional, 1, 'subtract');
        final duration = D4.getRequiredArg<Duration>(positional, 0, 'duration', 'subtract');
        return t.subtract(duration);
      },
      'difference': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        D4.requireMinArgs(positional, 1, 'difference');
        final other = D4.getRequiredArg<DateTime>(positional, 0, 'other', 'difference');
        return t.difference(other);
      },
      'convertToTimezone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        D4.requireMinArgs(positional, 1, 'convertToTimezone');
        final targetTimezone = D4.getRequiredArg<$tom_core_kernel_29.TomTimezone>(positional, 0, 'targetTimezone', 'convertToTimezone');
        return t.convertToTimezone(targetTimezone);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_28.TomZonedDateTime>(target, 'TomZonedDateTime');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'serializationPrefix': (visitor) => $tom_core_kernel_28.TomZonedDateTime.serializationPrefix,
    },
    staticMethods: {
      'isTomZonedDateTimeString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isTomZonedDateTimeString');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'isTomZonedDateTimeString');
        return $tom_core_kernel_28.TomZonedDateTime.isTomZonedDateTimeString(s);
      },
      'isTomDateTime': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isTomDateTime');
        final dt = D4.getRequiredArg<DateTime>(positional, 0, 'dt', 'isTomDateTime');
        return $tom_core_kernel_28.TomZonedDateTime.isTomDateTime(dt);
      },
    },
    constructorSignatures: {
      '': 'factory TomZonedDateTime({int year = 1970, int month = 1, int day = 1, int hour = 0, int minute = 0, int second = 0, int millisecond = 0, int microsecond = 0, TomTimezone? timezone})',
      'fromDateTime': 'factory TomZonedDateTime.fromDateTime(DateTime dtx, [TomTimezone? timezone])',
      'parseFromString': 'factory TomZonedDateTime.parseFromString(String formattedString)',
    },
    methodSignatures: {
      'getSerializationPrefix': 'String getSerializationPrefix()',
      'toString': 'String toString()',
      'toDateTime': 'DateTime toDateTime()',
      'isBefore': 'bool isBefore(DateTime other)',
      'isAfter': 'bool isAfter(DateTime other)',
      'isAtSameMomentAs': 'bool isAtSameMomentAs(DateTime other)',
      'compareTo': 'int compareTo(DateTime other)',
      'toLocal': 'DateTime toLocal()',
      'toUtc': 'DateTime toUtc()',
      'toIso8601String': 'String toIso8601String()',
      'add': 'DateTime add(Duration duration)',
      'subtract': 'DateTime subtract(Duration duration)',
      'difference': 'Duration difference(DateTime other)',
      'convertToTimezone': 'TomZonedDateTime convertToTimezone(TomTimezone targetTimezone)',
    },
    getterSignatures: {
      'timezone': 'TomTimezone get timezone',
      'localYear': 'int get localYear',
      'localMonth': 'int get localMonth',
      'localDay': 'int get localDay',
      'localHour': 'int get localHour',
      'localMinute': 'int get localMinute',
      'localSecond': 'int get localSecond',
      'localMillisecond': 'int get localMillisecond',
      'localMicrosecond': 'int get localMicrosecond',
      'localWeekday': 'int get localWeekday',
      'isUtc': 'bool get isUtc',
      'hashCode': 'int get hashCode',
      'millisecondsSinceEpoch': 'int get millisecondsSinceEpoch',
      'microsecondsSinceEpoch': 'int get microsecondsSinceEpoch',
      'timeZoneName': 'String get timeZoneName',
      'timeZoneOffset': 'Duration get timeZoneOffset',
      'year': 'int get year',
      'month': 'int get month',
      'day': 'int get day',
      'hour': 'int get hour',
      'minute': 'int get minute',
      'second': 'int get second',
      'millisecond': 'int get millisecond',
      'microsecond': 'int get microsecond',
      'weekday': 'int get weekday',
    },
    staticMethodSignatures: {
      'isTomZonedDateTimeString': 'bool isTomZonedDateTimeString(String s)',
      'isTomDateTime': 'bool isTomDateTime(DateTime dt)',
    },
    staticGetterSignatures: {
      'serializationPrefix': 'String get serializationPrefix',
    },
  );
}

// =============================================================================
// TomTimezoneException Bridge
// =============================================================================

BridgedClass _createTomTimezoneExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_29.TomTimezoneException,
    name: 'TomTimezoneException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomTimezoneException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomTimezoneException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomTimezoneException');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final autoLog = D4.getNamedArgWithDefault<bool>(named, 'autoLog', false);
        return $tom_core_kernel_29.TomTimezoneException(key, defaultUserMessage, parameters: parameters, stack: stack, rootException: rootException, autoLog: autoLog);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').stackTrace,
      'autoLog': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').autoLog,
      'serverCallError': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').serverCallError,
      'newField': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').newField,
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').logRepresentation,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').stackTrace = value as String,
      'autoLog': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').autoLog = value as bool,
      'serverCallError': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').serverCallError = value as $tom_core_kernel_8.TomServerCallError?,
      'newField': (visitor, target, value) => 
        D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException').newField = value as String?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezoneException>(target, 'TomTimezoneException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomTimezoneException(String key, String defaultUserMessage, {Map<String, Object?>? parameters, Object? stack, Object? rootException, bool autoLog = false})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
      'autoLog': 'bool get autoLog',
      'serverCallError': 'TomServerCallError? get serverCallError',
      'newField': 'String? get newField',
      'logRepresentation': 'String get logRepresentation',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
      'autoLog': 'set autoLog(dynamic value)',
      'serverCallError': 'set serverCallError(dynamic value)',
      'newField': 'set newField(dynamic value)',
    },
  );
}

// =============================================================================
// TomTimezone Bridge
// =============================================================================

BridgedClass _createTomTimezoneBridge() {
  return BridgedClass(
    nativeType: $tom_core_kernel_29.TomTimezone,
    name: 'TomTimezone',
    constructors: {
    },
    getters: {
      'timezone': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone').timezone,
      'location': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone').location,
      'timezoneOffsetMin': (visitor, target) => D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone').timezoneOffsetMin,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone');
        return t.toString();
      },
      'toStringOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone');
        D4.requireMinArgs(positional, 1, 'toStringOn');
        final when = D4.getRequiredArg<DateTime>(positional, 0, 'when', 'toStringOn');
        return t.toStringOn(when);
      },
      'getUtcOffsetOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone');
        D4.requireMinArgs(positional, 1, 'getUtcOffsetOn');
        final dt = D4.getRequiredArg<DateTime>(positional, 0, 'dt', 'getUtcOffsetOn');
        return t.getUtcOffsetOn(dt);
      },
      'getUtcOffsetStringOn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone');
        D4.requireMinArgs(positional, 1, 'getUtcOffsetStringOn');
        final dt = D4.getRequiredArg<DateTime>(positional, 0, 'dt', 'getUtcOffsetStringOn');
        return t.getUtcOffsetStringOn(dt);
      },
      'getCurrentUtcOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone');
        return t.getCurrentUtcOffset();
      },
      'getCurrentUtcOffsetString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone');
        return t.getCurrentUtcOffsetString();
      },
      'toTZDateTime': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone');
        D4.requireMinArgs(positional, 1, 'toTZDateTime');
        final dt = D4.getRequiredArg<DateTime>(positional, 0, 'dt', 'toTZDateTime');
        return t.toTZDateTime(dt);
      },
      'now': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone');
        return t.now();
      },
      'changeToThisLocation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_core_kernel_29.TomTimezone>(target, 'TomTimezone');
        D4.requireMinArgs(positional, 2, 'changeToThisLocation');
        final dt = D4.getRequiredArg<DateTime>(positional, 0, 'dt', 'changeToThisLocation');
        final inTimezone = D4.getRequiredArg<$tom_core_kernel_29.TomTimezone>(positional, 1, 'inTimezone', 'changeToThisLocation');
        return t.changeToThisLocation(dt, inTimezone);
      },
    },
    staticGetters: {
      'utc': (visitor) => $tom_core_kernel_29.TomTimezone.utc,
      'timezones': (visitor) => $tom_core_kernel_29.TomTimezone.timezones,
    },
    staticMethods: {
      'fromName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'fromName');
        return $tom_core_kernel_29.TomTimezone.fromName(name);
      },
      'firstWithOffset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'firstWithOffset');
        final utcOffsetMinutes = D4.getRequiredArg<int>(positional, 0, 'utcOffsetMinutes', 'firstWithOffset');
        return $tom_core_kernel_29.TomTimezone.firstWithOffset(utcOffsetMinutes);
      },
      'allWithOffset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'allWithOffset');
        final utcOffsetMinutes = D4.getRequiredArg<int>(positional, 0, 'utcOffsetMinutes', 'allWithOffset');
        return $tom_core_kernel_29.TomTimezone.allWithOffset(utcOffsetMinutes);
      },
      'findTimezone': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'findTimezone');
        final name = D4.getRequiredArg<String?>(positional, 0, 'name', 'findTimezone');
        final utcOffsetMinutes = D4.getRequiredArg<int?>(positional, 1, 'utcOffsetMinutes', 'findTimezone');
        return $tom_core_kernel_29.TomTimezone.findTimezone(name, utcOffsetMinutes);
      },
      'convertMinutesToUtcOffset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'convertMinutesToUtcOffset');
        final totalMinutes = D4.getRequiredArg<int>(positional, 0, 'totalMinutes', 'convertMinutesToUtcOffset');
        return $tom_core_kernel_29.TomTimezone.convertMinutesToUtcOffset(totalMinutes);
      },
      'changeLocation': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'changeLocation');
        final dt = D4.getRequiredArg<DateTime>(positional, 0, 'dt', 'changeLocation');
        final inTimezone = D4.getRequiredArg<$tom_core_kernel_29.TomTimezone>(positional, 1, 'inTimezone', 'changeLocation');
        final toTimezone = D4.getRequiredArg<$tom_core_kernel_29.TomTimezone>(positional, 2, 'toTimezone', 'changeLocation');
        return $tom_core_kernel_29.TomTimezone.changeLocation(dt, inTimezone, toTimezone);
      },
    },
    methodSignatures: {
      'toString': 'String toString()',
      'toStringOn': 'String toStringOn(DateTime when)',
      'getUtcOffsetOn': 'int getUtcOffsetOn(DateTime dt)',
      'getUtcOffsetStringOn': 'String getUtcOffsetStringOn(DateTime dt)',
      'getCurrentUtcOffset': 'int getCurrentUtcOffset()',
      'getCurrentUtcOffsetString': 'String getCurrentUtcOffsetString()',
      'toTZDateTime': 'tz.TZDateTime toTZDateTime(DateTime dt)',
      'now': 'DateTime now()',
      'changeToThisLocation': 'DateTime changeToThisLocation(DateTime dt, TomTimezone inTimezone)',
    },
    getterSignatures: {
      'timezone': 'String get timezone',
      'location': 'tz.Location get location',
      'timezoneOffsetMin': 'int get timezoneOffsetMin',
    },
    staticMethodSignatures: {
      'fromName': 'TomTimezone? fromName(String name)',
      'firstWithOffset': 'TomTimezone? firstWithOffset(int utcOffsetMinutes)',
      'allWithOffset': 'List<TomTimezone>? allWithOffset(int utcOffsetMinutes)',
      'findTimezone': 'TomTimezone? findTimezone(String? name, int? utcOffsetMinutes)',
      'convertMinutesToUtcOffset': 'String convertMinutesToUtcOffset(int totalMinutes)',
      'changeLocation': 'DateTime changeLocation(DateTime dt, TomTimezone inTimezone, TomTimezone toTimezone)',
    },
    staticGetterSignatures: {
      'utc': 'TomTimezone get utc',
      'timezones': 'Map<String, TomTimezone> get timezones',
    },
  );
}

// =============================================================================
// ReflectCapability Bridge
// =============================================================================

BridgedClass _createReflectCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.ReflectCapability,
    name: 'ReflectCapability',
    constructors: {
    },
  );
}

// =============================================================================
// ApiReflectCapability Bridge
// =============================================================================

BridgedClass _createApiReflectCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.ApiReflectCapability,
    name: 'ApiReflectCapability',
    constructors: {
    },
  );
}

// =============================================================================
// NamePatternCapability Bridge
// =============================================================================

BridgedClass _createNamePatternCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.NamePatternCapability,
    name: 'NamePatternCapability',
    constructors: {
    },
    getters: {
      'namePattern': (visitor, target) => D4.validateTarget<$tom_reflection_1.NamePatternCapability>(target, 'NamePatternCapability').namePattern,
    },
    getterSignatures: {
      'namePattern': 'String get namePattern',
    },
  );
}

// =============================================================================
// MetadataQuantifiedCapability Bridge
// =============================================================================

BridgedClass _createMetadataQuantifiedCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.MetadataQuantifiedCapability,
    name: 'MetadataQuantifiedCapability',
    constructors: {
    },
    getters: {
      'metadataType': (visitor, target) => D4.validateTarget<$tom_reflection_1.MetadataQuantifiedCapability>(target, 'MetadataQuantifiedCapability').metadataType,
    },
    getterSignatures: {
      'metadataType': 'Type get metadataType',
    },
  );
}

// =============================================================================
// InstanceInvokeCapability Bridge
// =============================================================================

BridgedClass _createInstanceInvokeCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.InstanceInvokeCapability,
    name: 'InstanceInvokeCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InstanceInvokeCapability');
        final namePattern = D4.getRequiredArg<String>(positional, 0, 'namePattern', 'InstanceInvokeCapability');
        return $tom_reflection_1.InstanceInvokeCapability(namePattern);
      },
    },
    getters: {
      'namePattern': (visitor, target) => D4.validateTarget<$tom_reflection_1.InstanceInvokeCapability>(target, 'InstanceInvokeCapability').namePattern,
    },
    constructorSignatures: {
      '': 'const InstanceInvokeCapability(String namePattern)',
    },
    getterSignatures: {
      'namePattern': 'String get namePattern',
    },
  );
}

// =============================================================================
// InstanceInvokeMetaCapability Bridge
// =============================================================================

BridgedClass _createInstanceInvokeMetaCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.InstanceInvokeMetaCapability,
    name: 'InstanceInvokeMetaCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InstanceInvokeMetaCapability');
        final metadataType = D4.getRequiredArg<Type>(positional, 0, 'metadataType', 'InstanceInvokeMetaCapability');
        return $tom_reflection_1.InstanceInvokeMetaCapability(metadataType);
      },
    },
    getters: {
      'metadataType': (visitor, target) => D4.validateTarget<$tom_reflection_1.InstanceInvokeMetaCapability>(target, 'InstanceInvokeMetaCapability').metadataType,
    },
    constructorSignatures: {
      '': 'const InstanceInvokeMetaCapability(Type metadataType)',
    },
    getterSignatures: {
      'metadataType': 'Type get metadataType',
    },
  );
}

// =============================================================================
// StaticInvokeCapability Bridge
// =============================================================================

BridgedClass _createStaticInvokeCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.StaticInvokeCapability,
    name: 'StaticInvokeCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'StaticInvokeCapability');
        final namePattern = D4.getRequiredArg<String>(positional, 0, 'namePattern', 'StaticInvokeCapability');
        return $tom_reflection_1.StaticInvokeCapability(namePattern);
      },
    },
    getters: {
      'namePattern': (visitor, target) => D4.validateTarget<$tom_reflection_1.StaticInvokeCapability>(target, 'StaticInvokeCapability').namePattern,
    },
    constructorSignatures: {
      '': 'const StaticInvokeCapability(String namePattern)',
    },
    getterSignatures: {
      'namePattern': 'String get namePattern',
    },
  );
}

// =============================================================================
// StaticInvokeMetaCapability Bridge
// =============================================================================

BridgedClass _createStaticInvokeMetaCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.StaticInvokeMetaCapability,
    name: 'StaticInvokeMetaCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'StaticInvokeMetaCapability');
        final metadata = D4.getRequiredArg<Type>(positional, 0, 'metadata', 'StaticInvokeMetaCapability');
        return $tom_reflection_1.StaticInvokeMetaCapability(metadata);
      },
    },
    getters: {
      'metadataType': (visitor, target) => D4.validateTarget<$tom_reflection_1.StaticInvokeMetaCapability>(target, 'StaticInvokeMetaCapability').metadataType,
    },
    constructorSignatures: {
      '': 'const StaticInvokeMetaCapability(Type metadata)',
    },
    getterSignatures: {
      'metadataType': 'Type get metadataType',
    },
  );
}

// =============================================================================
// TopLevelInvokeCapability Bridge
// =============================================================================

BridgedClass _createTopLevelInvokeCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.TopLevelInvokeCapability,
    name: 'TopLevelInvokeCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TopLevelInvokeCapability');
        final namePattern = D4.getRequiredArg<String>(positional, 0, 'namePattern', 'TopLevelInvokeCapability');
        return $tom_reflection_1.TopLevelInvokeCapability(namePattern);
      },
    },
    getters: {
      'namePattern': (visitor, target) => D4.validateTarget<$tom_reflection_1.TopLevelInvokeCapability>(target, 'TopLevelInvokeCapability').namePattern,
    },
    constructorSignatures: {
      '': 'const TopLevelInvokeCapability(String namePattern)',
    },
    getterSignatures: {
      'namePattern': 'String get namePattern',
    },
  );
}

// =============================================================================
// TopLevelInvokeMetaCapability Bridge
// =============================================================================

BridgedClass _createTopLevelInvokeMetaCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.TopLevelInvokeMetaCapability,
    name: 'TopLevelInvokeMetaCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TopLevelInvokeMetaCapability');
        final metadataType = D4.getRequiredArg<Type>(positional, 0, 'metadataType', 'TopLevelInvokeMetaCapability');
        return $tom_reflection_1.TopLevelInvokeMetaCapability(metadataType);
      },
    },
    getters: {
      'metadataType': (visitor, target) => D4.validateTarget<$tom_reflection_1.TopLevelInvokeMetaCapability>(target, 'TopLevelInvokeMetaCapability').metadataType,
    },
    constructorSignatures: {
      '': 'const TopLevelInvokeMetaCapability(Type metadataType)',
    },
    getterSignatures: {
      'metadataType': 'Type get metadataType',
    },
  );
}

// =============================================================================
// NewInstanceCapability Bridge
// =============================================================================

BridgedClass _createNewInstanceCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.NewInstanceCapability,
    name: 'NewInstanceCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NewInstanceCapability');
        final namePattern = D4.getRequiredArg<String>(positional, 0, 'namePattern', 'NewInstanceCapability');
        return $tom_reflection_1.NewInstanceCapability(namePattern);
      },
    },
    getters: {
      'namePattern': (visitor, target) => D4.validateTarget<$tom_reflection_1.NewInstanceCapability>(target, 'NewInstanceCapability').namePattern,
    },
    constructorSignatures: {
      '': 'const NewInstanceCapability(String namePattern)',
    },
    getterSignatures: {
      'namePattern': 'String get namePattern',
    },
  );
}

// =============================================================================
// NewInstanceMetaCapability Bridge
// =============================================================================

BridgedClass _createNewInstanceMetaCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.NewInstanceMetaCapability,
    name: 'NewInstanceMetaCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NewInstanceMetaCapability');
        final metadataType = D4.getRequiredArg<Type>(positional, 0, 'metadataType', 'NewInstanceMetaCapability');
        return $tom_reflection_1.NewInstanceMetaCapability(metadataType);
      },
    },
    getters: {
      'metadataType': (visitor, target) => D4.validateTarget<$tom_reflection_1.NewInstanceMetaCapability>(target, 'NewInstanceMetaCapability').metadataType,
    },
    constructorSignatures: {
      '': 'const NewInstanceMetaCapability(Type metadataType)',
    },
    getterSignatures: {
      'metadataType': 'Type get metadataType',
    },
  );
}

// =============================================================================
// MetadataCapability Bridge
// =============================================================================

BridgedClass _createMetadataCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.MetadataCapability,
    name: 'MetadataCapability',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_reflection_1.MetadataCapability();
      },
    },
    constructorSignatures: {
      '': 'const MetadataCapability()',
    },
  );
}

// =============================================================================
// TypeCapability Bridge
// =============================================================================

BridgedClass _createTypeCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.TypeCapability,
    name: 'TypeCapability',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_reflection_1.TypeCapability();
      },
    },
    constructorSignatures: {
      '': 'const TypeCapability()',
    },
  );
}

// =============================================================================
// TypeRelationsCapability Bridge
// =============================================================================

BridgedClass _createTypeRelationsCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.TypeRelationsCapability,
    name: 'TypeRelationsCapability',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_reflection_1.TypeRelationsCapability();
      },
    },
    constructorSignatures: {
      '': 'const TypeRelationsCapability()',
    },
  );
}

// =============================================================================
// LibraryCapability Bridge
// =============================================================================

BridgedClass _createLibraryCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.LibraryCapability,
    name: 'LibraryCapability',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_reflection_1.LibraryCapability();
      },
    },
    constructorSignatures: {
      '': 'const LibraryCapability()',
    },
  );
}

// =============================================================================
// DeclarationsCapability Bridge
// =============================================================================

BridgedClass _createDeclarationsCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.DeclarationsCapability,
    name: 'DeclarationsCapability',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_reflection_1.DeclarationsCapability();
      },
    },
    constructorSignatures: {
      '': 'const DeclarationsCapability()',
    },
  );
}

// =============================================================================
// UriCapability Bridge
// =============================================================================

BridgedClass _createUriCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.UriCapability,
    name: 'UriCapability',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_reflection_1.UriCapability();
      },
    },
    constructorSignatures: {
      '': 'const UriCapability()',
    },
  );
}

// =============================================================================
// LibraryDependenciesCapability Bridge
// =============================================================================

BridgedClass _createLibraryDependenciesCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.LibraryDependenciesCapability,
    name: 'LibraryDependenciesCapability',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_reflection_1.LibraryDependenciesCapability();
      },
    },
    constructorSignatures: {
      '': 'const LibraryDependenciesCapability()',
    },
  );
}

// =============================================================================
// InvokingCapability Bridge
// =============================================================================

BridgedClass _createInvokingCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.InvokingCapability,
    name: 'InvokingCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InvokingCapability');
        final namePattern = D4.getRequiredArg<String>(positional, 0, 'namePattern', 'InvokingCapability');
        return $tom_reflection_1.InvokingCapability(namePattern);
      },
    },
    getters: {
      'namePattern': (visitor, target) => D4.validateTarget<$tom_reflection_1.InvokingCapability>(target, 'InvokingCapability').namePattern,
    },
    constructorSignatures: {
      '': 'const InvokingCapability(String namePattern)',
    },
    getterSignatures: {
      'namePattern': 'String get namePattern',
    },
  );
}

// =============================================================================
// InvokingMetaCapability Bridge
// =============================================================================

BridgedClass _createInvokingMetaCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.InvokingMetaCapability,
    name: 'InvokingMetaCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InvokingMetaCapability');
        final metadataType = D4.getRequiredArg<Type>(positional, 0, 'metadataType', 'InvokingMetaCapability');
        return $tom_reflection_1.InvokingMetaCapability(metadataType);
      },
    },
    getters: {
      'metadataType': (visitor, target) => D4.validateTarget<$tom_reflection_1.InvokingMetaCapability>(target, 'InvokingMetaCapability').metadataType,
    },
    constructorSignatures: {
      '': 'const InvokingMetaCapability(Type metadataType)',
    },
    getterSignatures: {
      'metadataType': 'Type get metadataType',
    },
  );
}

// =============================================================================
// TypingCapability Bridge
// =============================================================================

BridgedClass _createTypingCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.TypingCapability,
    name: 'TypingCapability',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_reflection_1.TypingCapability();
      },
    },
    constructorSignatures: {
      '': 'const TypingCapability()',
    },
  );
}

// =============================================================================
// ReflecteeQuantifyCapability Bridge
// =============================================================================

BridgedClass _createReflecteeQuantifyCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.ReflecteeQuantifyCapability,
    name: 'ReflecteeQuantifyCapability',
    constructors: {
    },
  );
}

// =============================================================================
// SuperclassQuantifyCapability Bridge
// =============================================================================

BridgedClass _createSuperclassQuantifyCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.SuperclassQuantifyCapability,
    name: 'SuperclassQuantifyCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SuperclassQuantifyCapability');
        final upperBound = D4.getRequiredArg<Type>(positional, 0, 'upperBound', 'SuperclassQuantifyCapability');
        final excludeUpperBound = D4.getNamedArgWithDefault<bool>(named, 'excludeUpperBound', false);
        return $tom_reflection_1.SuperclassQuantifyCapability(upperBound, excludeUpperBound: excludeUpperBound);
      },
    },
    getters: {
      'upperBound': (visitor, target) => D4.validateTarget<$tom_reflection_1.SuperclassQuantifyCapability>(target, 'SuperclassQuantifyCapability').upperBound,
      'excludeUpperBound': (visitor, target) => D4.validateTarget<$tom_reflection_1.SuperclassQuantifyCapability>(target, 'SuperclassQuantifyCapability').excludeUpperBound,
    },
    constructorSignatures: {
      '': 'const SuperclassQuantifyCapability(Type upperBound, {bool excludeUpperBound = false})',
    },
    getterSignatures: {
      'upperBound': 'Type get upperBound',
      'excludeUpperBound': 'bool get excludeUpperBound',
    },
  );
}

// =============================================================================
// TypeAnnotationQuantifyCapability Bridge
// =============================================================================

BridgedClass _createTypeAnnotationQuantifyCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.TypeAnnotationQuantifyCapability,
    name: 'TypeAnnotationQuantifyCapability',
    constructors: {
      '': (visitor, positional, named) {
        final transitive = D4.getNamedArgWithDefault<bool>(named, 'transitive', false);
        return $tom_reflection_1.TypeAnnotationQuantifyCapability(transitive: transitive);
      },
    },
    getters: {
      'transitive': (visitor, target) => D4.validateTarget<$tom_reflection_1.TypeAnnotationQuantifyCapability>(target, 'TypeAnnotationQuantifyCapability').transitive,
    },
    constructorSignatures: {
      '': 'const TypeAnnotationQuantifyCapability({bool transitive = false})',
    },
    getterSignatures: {
      'transitive': 'bool get transitive',
    },
  );
}

// =============================================================================
// ImportAttachedCapability Bridge
// =============================================================================

BridgedClass _createImportAttachedCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.ImportAttachedCapability,
    name: 'ImportAttachedCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ImportAttachedCapability');
        final reflector = D4.getRequiredArg<$tom_reflection_4.Reflection>(positional, 0, 'reflector', 'ImportAttachedCapability');
        return $tom_reflection_1.ImportAttachedCapability(reflector);
      },
    },
    getters: {
      'reflector': (visitor, target) => D4.validateTarget<$tom_reflection_1.ImportAttachedCapability>(target, 'ImportAttachedCapability').reflector,
    },
    constructorSignatures: {
      '': 'const ImportAttachedCapability(Reflection reflector)',
    },
    getterSignatures: {
      'reflector': 'Reflection get reflector',
    },
  );
}

// =============================================================================
// GlobalQuantifyCapability Bridge
// =============================================================================

BridgedClass _createGlobalQuantifyCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.GlobalQuantifyCapability,
    name: 'GlobalQuantifyCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'GlobalQuantifyCapability');
        final classNamePattern = D4.getRequiredArg<String>(positional, 0, 'classNamePattern', 'GlobalQuantifyCapability');
        final reflector = D4.getRequiredArg<$tom_reflection_4.Reflection>(positional, 1, 'reflector', 'GlobalQuantifyCapability');
        return $tom_reflection_1.GlobalQuantifyCapability(classNamePattern, reflector);
      },
    },
    getters: {
      'reflector': (visitor, target) => D4.validateTarget<$tom_reflection_1.GlobalQuantifyCapability>(target, 'GlobalQuantifyCapability').reflector,
      'classNamePattern': (visitor, target) => D4.validateTarget<$tom_reflection_1.GlobalQuantifyCapability>(target, 'GlobalQuantifyCapability').classNamePattern,
    },
    constructorSignatures: {
      '': 'const GlobalQuantifyCapability(String classNamePattern, Reflection reflector)',
    },
    getterSignatures: {
      'reflector': 'Reflection get reflector',
      'classNamePattern': 'String get classNamePattern',
    },
  );
}

// =============================================================================
// GlobalQuantifyMetaCapability Bridge
// =============================================================================

BridgedClass _createGlobalQuantifyMetaCapabilityBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.GlobalQuantifyMetaCapability,
    name: 'GlobalQuantifyMetaCapability',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'GlobalQuantifyMetaCapability');
        final metadataType = D4.getRequiredArg<Type>(positional, 0, 'metadataType', 'GlobalQuantifyMetaCapability');
        final reflector = D4.getRequiredArg<$tom_reflection_4.Reflection>(positional, 1, 'reflector', 'GlobalQuantifyMetaCapability');
        return $tom_reflection_1.GlobalQuantifyMetaCapability(metadataType, reflector);
      },
    },
    getters: {
      'reflector': (visitor, target) => D4.validateTarget<$tom_reflection_1.GlobalQuantifyMetaCapability>(target, 'GlobalQuantifyMetaCapability').reflector,
      'metadataType': (visitor, target) => D4.validateTarget<$tom_reflection_1.GlobalQuantifyMetaCapability>(target, 'GlobalQuantifyMetaCapability').metadataType,
    },
    constructorSignatures: {
      '': 'const GlobalQuantifyMetaCapability(Type metadataType, Reflection reflector)',
    },
    getterSignatures: {
      'reflector': 'Reflection get reflector',
      'metadataType': 'Type get metadataType',
    },
  );
}

// =============================================================================
// NoSuchCapabilityError Bridge
// =============================================================================

BridgedClass _createNoSuchCapabilityErrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.NoSuchCapabilityError,
    name: 'NoSuchCapabilityError',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NoSuchCapabilityError');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'NoSuchCapabilityError');
        return $tom_reflection_1.NoSuchCapabilityError(message);
      },
    },
    getters: {
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_reflection_1.NoSuchCapabilityError>(target, 'NoSuchCapabilityError').stackTrace,
    },
    constructorSignatures: {
      '': 'factory NoSuchCapabilityError(String message)',
    },
    getterSignatures: {
      'stackTrace': 'StackTrace? get stackTrace',
    },
  );
}

// =============================================================================
// ReflectionNoSuchMethodError Bridge
// =============================================================================

BridgedClass _createReflectionNoSuchMethodErrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_1.ReflectionNoSuchMethodError,
    name: 'ReflectionNoSuchMethodError',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'ReflectionNoSuchMethodError');
        final receiver = D4.getRequiredArg<Object?>(positional, 0, 'receiver', 'ReflectionNoSuchMethodError');
        final memberName = D4.getRequiredArg<String>(positional, 1, 'memberName', 'ReflectionNoSuchMethodError');
        if (positional.length <= 2) {
          throw ArgumentError('ReflectionNoSuchMethodError: Missing required argument "positionalArguments" at position 2');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[2], 'positionalArguments');
        if (positional.length <= 3) {
          throw ArgumentError('ReflectionNoSuchMethodError: Missing required argument "namedArguments" at position 3');
        }
        final namedArguments = D4.coerceMapOrNull<Symbol, dynamic>(positional[3], 'namedArguments');
        final kind = D4.getRequiredArg<$tom_reflection_1.StringInvocationKind>(positional, 4, 'kind', 'ReflectionNoSuchMethodError');
        return $tom_reflection_1.ReflectionNoSuchMethodError(receiver, memberName, positionalArguments, namedArguments, kind);
      },
    },
    getters: {
      'receiver': (visitor, target) => D4.validateTarget<$tom_reflection_1.ReflectionNoSuchMethodError>(target, 'ReflectionNoSuchMethodError').receiver,
      'memberName': (visitor, target) => D4.validateTarget<$tom_reflection_1.ReflectionNoSuchMethodError>(target, 'ReflectionNoSuchMethodError').memberName,
      'positionalArguments': (visitor, target) => D4.validateTarget<$tom_reflection_1.ReflectionNoSuchMethodError>(target, 'ReflectionNoSuchMethodError').positionalArguments,
      'namedArguments': (visitor, target) => D4.validateTarget<$tom_reflection_1.ReflectionNoSuchMethodError>(target, 'ReflectionNoSuchMethodError').namedArguments,
      'kind': (visitor, target) => D4.validateTarget<$tom_reflection_1.ReflectionNoSuchMethodError>(target, 'ReflectionNoSuchMethodError').kind,
      'invocation': (visitor, target) => D4.validateTarget<$tom_reflection_1.ReflectionNoSuchMethodError>(target, 'ReflectionNoSuchMethodError').invocation,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_reflection_1.ReflectionNoSuchMethodError>(target, 'ReflectionNoSuchMethodError').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_1.ReflectionNoSuchMethodError>(target, 'ReflectionNoSuchMethodError');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ReflectionNoSuchMethodError(Object? receiver, String memberName, List<dynamic> positionalArguments, Map<Symbol, dynamic>? namedArguments, StringInvocationKind kind)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'receiver': 'Object? get receiver',
      'memberName': 'String get memberName',
      'positionalArguments': 'List get positionalArguments',
      'namedArguments': 'Map<Symbol, dynamic>? get namedArguments',
      'kind': 'StringInvocationKind get kind',
      'invocation': 'StringInvocation get invocation',
      'stackTrace': 'StackTrace? get stackTrace',
    },
  );
}

// =============================================================================
// Mirror Bridge
// =============================================================================

BridgedClass _createMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.Mirror,
    name: 'Mirror',
    constructors: {
    },
  );
}

// =============================================================================
// DeclarationMirror Bridge
// =============================================================================

BridgedClass _createDeclarationMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.DeclarationMirror,
    name: 'DeclarationMirror',
    constructors: {
    },
    getters: {
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.DeclarationMirror>(target, 'DeclarationMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.DeclarationMirror>(target, 'DeclarationMirror').qualifiedName,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.DeclarationMirror>(target, 'DeclarationMirror').owner,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.DeclarationMirror>(target, 'DeclarationMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.DeclarationMirror>(target, 'DeclarationMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.DeclarationMirror>(target, 'DeclarationMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.DeclarationMirror>(target, 'DeclarationMirror').metadata,
    },
    getterSignatures: {
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'owner': 'DeclarationMirror? get owner',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
    },
  );
}

// =============================================================================
// ObjectMirror Bridge
// =============================================================================

BridgedClass _createObjectMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.ObjectMirror,
    name: 'ObjectMirror',
    constructors: {
    },
    methods: {
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ObjectMirror>(target, 'ObjectMirror');
        D4.requireMinArgs(positional, 2, 'invoke');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoke');
        final positionalArguments = D4.getRequiredArg<List>(positional, 1, 'positionalArguments', 'invoke');
        final namedArguments = positional.length > 2
            ? D4.coerceMapOrNull<Symbol, dynamic>(positional[2], 'namedArguments')
            : null;
        return t.invoke(memberName, positionalArguments, namedArguments);
      },
      'invokeGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ObjectMirror>(target, 'ObjectMirror');
        D4.requireMinArgs(positional, 1, 'invokeGetter');
        final getterName = D4.getRequiredArg<String>(positional, 0, 'getterName', 'invokeGetter');
        return t.invokeGetter(getterName);
      },
      'invokeSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ObjectMirror>(target, 'ObjectMirror');
        D4.requireMinArgs(positional, 2, 'invokeSetter');
        final setterName = D4.getRequiredArg<String>(positional, 0, 'setterName', 'invokeSetter');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'invokeSetter');
        return t.invokeSetter(setterName, value);
      },
    },
    methodSignatures: {
      'invoke': 'Object? invoke(String memberName, List positionalArguments, [Map<Symbol, dynamic>? namedArguments])',
      'invokeGetter': 'Object? invokeGetter(String getterName)',
      'invokeSetter': 'Object? invokeSetter(String setterName, Object? value)',
    },
  );
}

// =============================================================================
// InstanceMirror Bridge
// =============================================================================

BridgedClass _createInstanceMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.InstanceMirror,
    name: 'InstanceMirror',
    constructors: {
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_reflection_2.InstanceMirror>(target, 'InstanceMirror').type,
      'hasReflectee': (visitor, target) => D4.validateTarget<$tom_reflection_2.InstanceMirror>(target, 'InstanceMirror').hasReflectee,
      'reflectee': (visitor, target) => D4.validateTarget<$tom_reflection_2.InstanceMirror>(target, 'InstanceMirror').reflectee,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_2.InstanceMirror>(target, 'InstanceMirror').hashCode,
    },
    methods: {
      'delegate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.InstanceMirror>(target, 'InstanceMirror');
        D4.requireMinArgs(positional, 1, 'delegate');
        final invocation = D4.getRequiredArg<Invocation>(positional, 0, 'invocation', 'delegate');
        return t.delegate(invocation);
      },
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.InstanceMirror>(target, 'InstanceMirror');
        D4.requireMinArgs(positional, 2, 'invoke');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoke');
        if (positional.length <= 1) {
          throw ArgumentError('invoke: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMapOrNull<Symbol, dynamic>(positional[2], 'namedArguments')
            : null;
        return t.invoke(memberName, positionalArguments, namedArguments);
      },
      'invokeGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.InstanceMirror>(target, 'InstanceMirror');
        D4.requireMinArgs(positional, 1, 'invokeGetter');
        final getterName = D4.getRequiredArg<String>(positional, 0, 'getterName', 'invokeGetter');
        return t.invokeGetter(getterName);
      },
      'invokeSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.InstanceMirror>(target, 'InstanceMirror');
        D4.requireMinArgs(positional, 2, 'invokeSetter');
        final setterName = D4.getRequiredArg<String>(positional, 0, 'setterName', 'invokeSetter');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'invokeSetter');
        return t.invokeSetter(setterName, value);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.InstanceMirror>(target, 'InstanceMirror');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'delegate': 'Object? delegate(Invocation invocation)',
      'invoke': 'Object? invoke(String memberName, List<dynamic> positionalArguments, [Map<Symbol, dynamic>? namedArguments])',
      'invokeGetter': 'Object? invokeGetter(String getterName)',
      'invokeSetter': 'Object? invokeSetter(String setterName, Object? value)',
    },
    getterSignatures: {
      'type': 'ClassMirror get type',
      'hasReflectee': 'bool get hasReflectee',
      'reflectee': 'Object? get reflectee',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ClosureMirror Bridge
// =============================================================================

BridgedClass _createClosureMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.ClosureMirror,
    name: 'ClosureMirror',
    constructors: {
    },
    getters: {
      'function': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror').function,
      'type': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror').type,
      'hasReflectee': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror').hasReflectee,
      'reflectee': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror').reflectee,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror').hashCode,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror');
        D4.requireMinArgs(positional, 1, 'apply');
        final positionalArguments = D4.getRequiredArg<List>(positional, 0, 'positionalArguments', 'apply');
        final namedArguments = positional.length > 1
            ? D4.coerceMapOrNull<Symbol, dynamic>(positional[1], 'namedArguments')
            : null;
        return t.apply(positionalArguments, namedArguments);
      },
      'delegate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror');
        D4.requireMinArgs(positional, 1, 'delegate');
        final invocation = D4.getRequiredArg<Invocation>(positional, 0, 'invocation', 'delegate');
        return t.delegate(invocation);
      },
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror');
        D4.requireMinArgs(positional, 2, 'invoke');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoke');
        if (positional.length <= 1) {
          throw ArgumentError('invoke: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMapOrNull<Symbol, dynamic>(positional[2], 'namedArguments')
            : null;
        return t.invoke(memberName, positionalArguments, namedArguments);
      },
      'invokeGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror');
        D4.requireMinArgs(positional, 1, 'invokeGetter');
        final getterName = D4.getRequiredArg<String>(positional, 0, 'getterName', 'invokeGetter');
        return t.invokeGetter(getterName);
      },
      'invokeSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror');
        D4.requireMinArgs(positional, 2, 'invokeSetter');
        final setterName = D4.getRequiredArg<String>(positional, 0, 'setterName', 'invokeSetter');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'invokeSetter');
        return t.invokeSetter(setterName, value);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClosureMirror>(target, 'ClosureMirror');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'apply': 'Object? apply(List positionalArguments, [Map<Symbol, dynamic>? namedArguments])',
      'delegate': 'Object? delegate(Invocation invocation)',
      'invoke': 'Object? invoke(String memberName, List<dynamic> positionalArguments, [Map<Symbol, dynamic>? namedArguments])',
      'invokeGetter': 'Object? invokeGetter(String getterName)',
      'invokeSetter': 'Object? invokeSetter(String setterName, Object? value)',
    },
    getterSignatures: {
      'function': 'MethodMirror get function',
      'type': 'ClassMirror<dynamic> get type',
      'hasReflectee': 'bool get hasReflectee',
      'reflectee': 'Object? get reflectee',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// LibraryMirror Bridge
// =============================================================================

BridgedClass _createLibraryMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.LibraryMirror,
    name: 'LibraryMirror',
    constructors: {
    },
    getters: {
      'uri': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').uri,
      'declarations': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').declarations,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').hashCode,
      'libraryDependencies': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').libraryDependencies,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').owner,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').qualifiedName,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror').metadata,
    },
    methods: {
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror');
        D4.requireMinArgs(positional, 2, 'invoke');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoke');
        if (positional.length <= 1) {
          throw ArgumentError('invoke: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMapOrNull<Symbol, dynamic>(positional[2], 'namedArguments')
            : null;
        return t.invoke(memberName, positionalArguments, namedArguments);
      },
      'invokeGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror');
        D4.requireMinArgs(positional, 1, 'invokeGetter');
        final getterName = D4.getRequiredArg<String>(positional, 0, 'getterName', 'invokeGetter');
        return t.invokeGetter(getterName);
      },
      'invokeSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror');
        D4.requireMinArgs(positional, 2, 'invokeSetter');
        final setterName = D4.getRequiredArg<String>(positional, 0, 'setterName', 'invokeSetter');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'invokeSetter');
        return t.invokeSetter(setterName, value);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.LibraryMirror>(target, 'LibraryMirror');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'invoke': 'Object? invoke(String memberName, List<dynamic> positionalArguments, [Map<Symbol, dynamic>? namedArguments])',
      'invokeGetter': 'Object? invokeGetter(String getterName)',
      'invokeSetter': 'Object? invokeSetter(String setterName, Object? value)',
    },
    getterSignatures: {
      'uri': 'Uri get uri',
      'declarations': 'Map<String, DeclarationMirror> get declarations',
      'hashCode': 'int get hashCode',
      'libraryDependencies': 'List<LibraryDependencyMirror> get libraryDependencies',
      'owner': 'Null get owner',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
    },
  );
}

// =============================================================================
// LibraryDependencyMirror Bridge
// =============================================================================

BridgedClass _createLibraryDependencyMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.LibraryDependencyMirror,
    name: 'LibraryDependencyMirror',
    constructors: {
    },
    getters: {
      'isImport': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryDependencyMirror>(target, 'LibraryDependencyMirror').isImport,
      'isExport': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryDependencyMirror>(target, 'LibraryDependencyMirror').isExport,
      'isDeferred': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryDependencyMirror>(target, 'LibraryDependencyMirror').isDeferred,
      'sourceLibrary': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryDependencyMirror>(target, 'LibraryDependencyMirror').sourceLibrary,
      'targetLibrary': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryDependencyMirror>(target, 'LibraryDependencyMirror').targetLibrary,
      'prefix': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryDependencyMirror>(target, 'LibraryDependencyMirror').prefix,
      'combinators': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryDependencyMirror>(target, 'LibraryDependencyMirror').combinators,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryDependencyMirror>(target, 'LibraryDependencyMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.LibraryDependencyMirror>(target, 'LibraryDependencyMirror').metadata,
    },
    getterSignatures: {
      'isImport': 'bool get isImport',
      'isExport': 'bool get isExport',
      'isDeferred': 'bool get isDeferred',
      'sourceLibrary': 'LibraryMirror get sourceLibrary',
      'targetLibrary': 'LibraryMirror get targetLibrary',
      'prefix': 'String get prefix',
      'combinators': 'List<CombinatorMirror> get combinators',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object?> get metadata',
    },
  );
}

// =============================================================================
// CombinatorMirror Bridge
// =============================================================================

BridgedClass _createCombinatorMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.CombinatorMirror,
    name: 'CombinatorMirror',
    constructors: {
    },
    getters: {
      'identifiers': (visitor, target) => D4.validateTarget<$tom_reflection_2.CombinatorMirror>(target, 'CombinatorMirror').identifiers,
      'isShow': (visitor, target) => D4.validateTarget<$tom_reflection_2.CombinatorMirror>(target, 'CombinatorMirror').isShow,
      'isHide': (visitor, target) => D4.validateTarget<$tom_reflection_2.CombinatorMirror>(target, 'CombinatorMirror').isHide,
    },
    getterSignatures: {
      'identifiers': 'List<String> get identifiers',
      'isShow': 'bool get isShow',
      'isHide': 'bool get isHide',
    },
  );
}

// =============================================================================
// TypeMirror Bridge
// =============================================================================

BridgedClass _createTypeMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.TypeMirror,
    name: 'TypeMirror',
    constructors: {
    },
    getters: {
      'reflectedGenericType': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').reflectedGenericType,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').reflectedType,
      'typeVariables': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').typeVariables,
      'typeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').typeArguments,
      'reflectedTypeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').reflectedTypeArguments,
      'isOriginalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').isOriginalDeclaration,
      'originalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').originalDeclaration,
      'isNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').isNullable,
      'isNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').isNonNullable,
      'isPotentiallyNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').isPotentiallyNullable,
      'isPotentiallyNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').isPotentiallyNonNullable,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').qualifiedName,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').owner,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror').metadata,
    },
    methods: {
      'createList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        return t.createList();
      },
      'createSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        return t.createSet();
      },
      'createValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        return t.createValuedMap();
      },
      'createKeyedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        return t.createKeyedMap();
      },
      'createKeyedValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        return t.createKeyedValuedMap();
      },
      'isInstanceOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        D4.requireMinArgs(positional, 1, 'isInstanceOf');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'isInstanceOf');
        return t.isInstanceOf(object);
      },
      'isSubtype': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        return t.isSubtype();
      },
      'createNullableList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        return t.createNullableList();
      },
      'createNullableSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        return t.createNullableSet();
      },
      'createNullableValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        return t.createNullableValuedMap();
      },
      'isSubtypeOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        D4.requireMinArgs(positional, 1, 'isSubtypeOf');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror>(positional, 0, 'other', 'isSubtypeOf');
        return t.isSubtypeOf(other);
      },
      'isAssignableTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeMirror>(target, 'TypeMirror');
        D4.requireMinArgs(positional, 1, 'isAssignableTo');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror>(positional, 0, 'other', 'isAssignableTo');
        return t.isAssignableTo(other);
      },
    },
    methodSignatures: {
      'createList': 'List<T> createList()',
      'createSet': 'Set<T> createSet()',
      'createValuedMap': 'Map<K, T> createValuedMap()',
      'createKeyedMap': 'Map<T, V> createKeyedMap()',
      'createKeyedValuedMap': 'Map<T, T> createKeyedValuedMap()',
      'isInstanceOf': 'bool isInstanceOf(Object? object)',
      'isSubtype': 'bool isSubtype()',
      'createNullableList': 'List<T?> createNullableList()',
      'createNullableSet': 'Set<T?> createNullableSet()',
      'createNullableValuedMap': 'Map<K, T?> createNullableValuedMap()',
      'isSubtypeOf': 'bool isSubtypeOf(TypeMirror other)',
      'isAssignableTo': 'bool isAssignableTo(TypeMirror other)',
    },
    getterSignatures: {
      'reflectedGenericType': 'Type get reflectedGenericType',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'typeVariables': 'List<TypeVariableMirror> get typeVariables',
      'typeArguments': 'List<TypeMirror> get typeArguments',
      'reflectedTypeArguments': 'List<Type> get reflectedTypeArguments',
      'isOriginalDeclaration': 'bool get isOriginalDeclaration',
      'originalDeclaration': 'TypeMirror get originalDeclaration',
      'isNullable': 'bool get isNullable',
      'isNonNullable': 'bool get isNonNullable',
      'isPotentiallyNullable': 'bool get isPotentiallyNullable',
      'isPotentiallyNonNullable': 'bool get isPotentiallyNonNullable',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'owner': 'DeclarationMirror? get owner',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
    },
  );
}

// =============================================================================
// ClassMirror Bridge
// =============================================================================

BridgedClass _createClassMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.ClassMirror,
    name: 'ClassMirror',
    constructors: {
    },
    getters: {
      'superclass': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').superclass,
      'superinterfaces': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').superinterfaces,
      'isAbstract': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').isAbstract,
      'isEnum': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').isEnum,
      'declarations': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').declarations,
      'instanceMembers': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').instanceMembers,
      'staticMembers': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').staticMembers,
      'mixin': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').mixin,
      'hasDynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').hasDynamicReflectedType,
      'dynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').dynamicReflectedType,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').hashCode,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').owner,
      'reflectedGenericType': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').reflectedGenericType,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').reflectedType,
      'typeVariables': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').typeVariables,
      'typeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').typeArguments,
      'reflectedTypeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').reflectedTypeArguments,
      'isOriginalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').isOriginalDeclaration,
      'originalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').originalDeclaration,
      'isNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').isNullable,
      'isNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').isNonNullable,
      'isPotentiallyNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').isPotentiallyNullable,
      'isPotentiallyNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').isPotentiallyNonNullable,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').qualifiedName,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror').metadata,
    },
    methods: {
      'createList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        return t.createList();
      },
      'createSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        return t.createSet();
      },
      'createValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        return t.createValuedMap();
      },
      'createKeyedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        return t.createKeyedMap();
      },
      'createKeyedValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        return t.createKeyedValuedMap();
      },
      'newInstance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        D4.requireMinArgs(positional, 2, 'newInstance');
        final constructorName = D4.getRequiredArg<String>(positional, 0, 'constructorName', 'newInstance');
        final positionalArguments = D4.getRequiredArg<List>(positional, 1, 'positionalArguments', 'newInstance');
        final namedArguments = positional.length > 2
            ? D4.coerceMap<Symbol, dynamic>(positional[2], 'namedArguments')
            : <Symbol, dynamic>{};
        return t.newInstance(constructorName, positionalArguments, namedArguments);
      },
      'isSubclassOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        D4.requireMinArgs(positional, 1, 'isSubclassOf');
        final other = D4.getRequiredArg<$tom_reflection_2.ClassMirror>(positional, 0, 'other', 'isSubclassOf');
        return t.isSubclassOf(other);
      },
      'invoker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        D4.requireMinArgs(positional, 1, 'invoker');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoker');
        return t.invoker(memberName);
      },
      'isInstanceOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        D4.requireMinArgs(positional, 1, 'isInstanceOf');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'isInstanceOf');
        return t.isInstanceOf(object);
      },
      'isSubtype': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        return t.isSubtype();
      },
      'createNullableList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        return t.createNullableList();
      },
      'createNullableSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        return t.createNullableSet();
      },
      'createNullableValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        return t.createNullableValuedMap();
      },
      'isSubtypeOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        D4.requireMinArgs(positional, 1, 'isSubtypeOf');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isSubtypeOf');
        return t.isSubtypeOf(other);
      },
      'isAssignableTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        D4.requireMinArgs(positional, 1, 'isAssignableTo');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isAssignableTo');
        return t.isAssignableTo(other);
      },
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        D4.requireMinArgs(positional, 2, 'invoke');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoke');
        if (positional.length <= 1) {
          throw ArgumentError('invoke: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMapOrNull<Symbol, dynamic>(positional[2], 'namedArguments')
            : null;
        return t.invoke(memberName, positionalArguments, namedArguments);
      },
      'invokeGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        D4.requireMinArgs(positional, 1, 'invokeGetter');
        final getterName = D4.getRequiredArg<String>(positional, 0, 'getterName', 'invokeGetter');
        return t.invokeGetter(getterName);
      },
      'invokeSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        D4.requireMinArgs(positional, 2, 'invokeSetter');
        final setterName = D4.getRequiredArg<String>(positional, 0, 'setterName', 'invokeSetter');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'invokeSetter');
        return t.invokeSetter(setterName, value);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ClassMirror>(target, 'ClassMirror');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'createList': 'List<T> createList()',
      'createSet': 'Set<T> createSet()',
      'createValuedMap': 'Map<K, T> createValuedMap()',
      'createKeyedMap': 'Map<T, V> createKeyedMap()',
      'createKeyedValuedMap': 'Map<T, T> createKeyedValuedMap()',
      'newInstance': 'Object newInstance(String constructorName, List positionalArguments, [Map<Symbol, dynamic> namedArguments])',
      'isSubclassOf': 'bool isSubclassOf(ClassMirror other)',
      'invoker': 'Function invoker(String memberName)',
      'isInstanceOf': 'bool isInstanceOf(Object? object)',
      'isSubtype': 'bool isSubtype()',
      'createNullableList': 'List<T> createNullableList()',
      'createNullableSet': 'Set<T> createNullableSet()',
      'createNullableValuedMap': 'Map<dynamic, T> createNullableValuedMap()',
      'isSubtypeOf': 'bool isSubtypeOf(TypeMirror<dynamic> other)',
      'isAssignableTo': 'bool isAssignableTo(TypeMirror<dynamic> other)',
      'invoke': 'Object? invoke(String memberName, List<dynamic> positionalArguments, [Map<Symbol, dynamic>? namedArguments])',
      'invokeGetter': 'Object? invokeGetter(String getterName)',
      'invokeSetter': 'Object? invokeSetter(String setterName, Object? value)',
    },
    getterSignatures: {
      'superclass': 'ClassMirror? get superclass',
      'superinterfaces': 'List<ClassMirror> get superinterfaces',
      'isAbstract': 'bool get isAbstract',
      'isEnum': 'bool get isEnum',
      'declarations': 'Map<String, DeclarationMirror> get declarations',
      'instanceMembers': 'Map<String, MethodMirror> get instanceMembers',
      'staticMembers': 'Map<String, MethodMirror> get staticMembers',
      'mixin': 'ClassMirror get mixin',
      'hasDynamicReflectedType': 'bool get hasDynamicReflectedType',
      'dynamicReflectedType': 'Type get dynamicReflectedType',
      'hashCode': 'int get hashCode',
      'owner': 'DeclarationMirror get owner',
      'reflectedGenericType': 'Type get reflectedGenericType',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'typeVariables': 'List<TypeVariableMirror<dynamic>> get typeVariables',
      'typeArguments': 'List<TypeMirror<dynamic>> get typeArguments',
      'reflectedTypeArguments': 'List<Type> get reflectedTypeArguments',
      'isOriginalDeclaration': 'bool get isOriginalDeclaration',
      'originalDeclaration': 'TypeMirror<dynamic> get originalDeclaration',
      'isNullable': 'bool get isNullable',
      'isNonNullable': 'bool get isNonNullable',
      'isPotentiallyNullable': 'bool get isPotentiallyNullable',
      'isPotentiallyNonNullable': 'bool get isPotentiallyNonNullable',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
    },
  );
}

// =============================================================================
// FunctionTypeMirror Bridge
// =============================================================================

BridgedClass _createFunctionTypeMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.FunctionTypeMirror,
    name: 'FunctionTypeMirror',
    constructors: {
    },
    getters: {
      'returnType': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').returnType,
      'parameters': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').parameters,
      'callMethod': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').callMethod,
      'superclass': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').superclass,
      'superinterfaces': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').superinterfaces,
      'isAbstract': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').isAbstract,
      'isEnum': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').isEnum,
      'declarations': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').declarations,
      'instanceMembers': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').instanceMembers,
      'staticMembers': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').staticMembers,
      'mixin': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').mixin,
      'hasDynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').hasDynamicReflectedType,
      'dynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').dynamicReflectedType,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').hashCode,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').owner,
      'reflectedGenericType': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').reflectedGenericType,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').reflectedType,
      'typeVariables': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').typeVariables,
      'typeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').typeArguments,
      'reflectedTypeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').reflectedTypeArguments,
      'isOriginalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').isOriginalDeclaration,
      'originalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').originalDeclaration,
      'isNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').isNullable,
      'isNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').isNonNullable,
      'isPotentiallyNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').isPotentiallyNullable,
      'isPotentiallyNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').isPotentiallyNonNullable,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').qualifiedName,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror').metadata,
    },
    methods: {
      'createList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        return t.createList();
      },
      'createSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        return t.createSet();
      },
      'createValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        return t.createValuedMap();
      },
      'createKeyedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        return t.createKeyedMap();
      },
      'createKeyedValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        return t.createKeyedValuedMap();
      },
      'newInstance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        D4.requireMinArgs(positional, 2, 'newInstance');
        final constructorName = D4.getRequiredArg<String>(positional, 0, 'constructorName', 'newInstance');
        if (positional.length <= 1) {
          throw ArgumentError('newInstance: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMap<Symbol, dynamic>(positional[2], 'namedArguments')
            : <Symbol, dynamic>{};
        return t.newInstance(constructorName, positionalArguments, namedArguments);
      },
      'isSubclassOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        D4.requireMinArgs(positional, 1, 'isSubclassOf');
        final other = D4.getRequiredArg<$tom_reflection_2.ClassMirror<dynamic>>(positional, 0, 'other', 'isSubclassOf');
        return t.isSubclassOf(other);
      },
      'invoker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        D4.requireMinArgs(positional, 1, 'invoker');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoker');
        return t.invoker(memberName);
      },
      'isInstanceOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        D4.requireMinArgs(positional, 1, 'isInstanceOf');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'isInstanceOf');
        return t.isInstanceOf(object);
      },
      'isSubtype': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        return t.isSubtype();
      },
      'createNullableList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        return t.createNullableList();
      },
      'createNullableSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        return t.createNullableSet();
      },
      'createNullableValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        return t.createNullableValuedMap();
      },
      'isSubtypeOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        D4.requireMinArgs(positional, 1, 'isSubtypeOf');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isSubtypeOf');
        return t.isSubtypeOf(other);
      },
      'isAssignableTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        D4.requireMinArgs(positional, 1, 'isAssignableTo');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isAssignableTo');
        return t.isAssignableTo(other);
      },
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        D4.requireMinArgs(positional, 2, 'invoke');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoke');
        if (positional.length <= 1) {
          throw ArgumentError('invoke: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMapOrNull<Symbol, dynamic>(positional[2], 'namedArguments')
            : null;
        return t.invoke(memberName, positionalArguments, namedArguments);
      },
      'invokeGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        D4.requireMinArgs(positional, 1, 'invokeGetter');
        final getterName = D4.getRequiredArg<String>(positional, 0, 'getterName', 'invokeGetter');
        return t.invokeGetter(getterName);
      },
      'invokeSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        D4.requireMinArgs(positional, 2, 'invokeSetter');
        final setterName = D4.getRequiredArg<String>(positional, 0, 'setterName', 'invokeSetter');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'invokeSetter');
        return t.invokeSetter(setterName, value);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.FunctionTypeMirror>(target, 'FunctionTypeMirror');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'createList': 'List<T> createList()',
      'createSet': 'Set<T> createSet()',
      'createValuedMap': 'Map<dynamic, T> createValuedMap()',
      'createKeyedMap': 'Map<T, dynamic> createKeyedMap()',
      'createKeyedValuedMap': 'Map<T, T> createKeyedValuedMap()',
      'newInstance': 'Object newInstance(String constructorName, List<dynamic> positionalArguments, [Map<Symbol, dynamic> namedArguments])',
      'isSubclassOf': 'bool isSubclassOf(ClassMirror<dynamic> other)',
      'invoker': 'Function invoker(String memberName)',
      'isInstanceOf': 'bool isInstanceOf(Object? object)',
      'isSubtype': 'bool isSubtype()',
      'createNullableList': 'List<T> createNullableList()',
      'createNullableSet': 'Set<T> createNullableSet()',
      'createNullableValuedMap': 'Map<dynamic, T> createNullableValuedMap()',
      'isSubtypeOf': 'bool isSubtypeOf(TypeMirror<dynamic> other)',
      'isAssignableTo': 'bool isAssignableTo(TypeMirror<dynamic> other)',
      'invoke': 'Object? invoke(String memberName, List<dynamic> positionalArguments, [Map<Symbol, dynamic>? namedArguments])',
      'invokeGetter': 'Object? invokeGetter(String getterName)',
      'invokeSetter': 'Object? invokeSetter(String setterName, Object? value)',
    },
    getterSignatures: {
      'returnType': 'TypeMirror get returnType',
      'parameters': 'List<ParameterMirror> get parameters',
      'callMethod': 'MethodMirror get callMethod',
      'superclass': 'ClassMirror<dynamic> get superclass',
      'superinterfaces': 'List<ClassMirror<dynamic>> get superinterfaces',
      'isAbstract': 'bool get isAbstract',
      'isEnum': 'bool get isEnum',
      'declarations': 'Map<String, DeclarationMirror> get declarations',
      'instanceMembers': 'Map<String, MethodMirror> get instanceMembers',
      'staticMembers': 'Map<String, MethodMirror> get staticMembers',
      'mixin': 'ClassMirror<dynamic> get mixin',
      'hasDynamicReflectedType': 'bool get hasDynamicReflectedType',
      'dynamicReflectedType': 'Type get dynamicReflectedType',
      'hashCode': 'int get hashCode',
      'owner': 'DeclarationMirror get owner',
      'reflectedGenericType': 'Type get reflectedGenericType',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'typeVariables': 'List<TypeVariableMirror<dynamic>> get typeVariables',
      'typeArguments': 'List<TypeMirror<dynamic>> get typeArguments',
      'reflectedTypeArguments': 'List<Type> get reflectedTypeArguments',
      'isOriginalDeclaration': 'bool get isOriginalDeclaration',
      'originalDeclaration': 'TypeMirror<dynamic> get originalDeclaration',
      'isNullable': 'bool get isNullable',
      'isNonNullable': 'bool get isNonNullable',
      'isPotentiallyNullable': 'bool get isPotentiallyNullable',
      'isPotentiallyNonNullable': 'bool get isPotentiallyNonNullable',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
    },
  );
}

// =============================================================================
// TypeVariableMirror Bridge
// =============================================================================

BridgedClass _createTypeVariableMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.TypeVariableMirror,
    name: 'TypeVariableMirror',
    constructors: {
    },
    getters: {
      'reflectedGenericType': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').reflectedGenericType,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').reflectedType,
      'typeVariables': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').typeVariables,
      'typeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').typeArguments,
      'reflectedTypeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').reflectedTypeArguments,
      'isOriginalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').isOriginalDeclaration,
      'originalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').originalDeclaration,
      'isNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').isNullable,
      'isNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').isNonNullable,
      'isPotentiallyNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').isPotentiallyNullable,
      'isPotentiallyNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').isPotentiallyNonNullable,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').qualifiedName,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').owner,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').metadata,
      'upperBound': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').upperBound,
      'isStatic': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').isStatic,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror').hashCode,
    },
    methods: {
      'createList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        return t.createList();
      },
      'createSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        return t.createSet();
      },
      'createValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        return t.createValuedMap();
      },
      'createKeyedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        return t.createKeyedMap();
      },
      'createKeyedValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        return t.createKeyedValuedMap();
      },
      'isInstanceOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        D4.requireMinArgs(positional, 1, 'isInstanceOf');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'isInstanceOf');
        return t.isInstanceOf(object);
      },
      'isSubtype': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        return t.isSubtype();
      },
      'createNullableList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        return t.createNullableList();
      },
      'createNullableSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        return t.createNullableSet();
      },
      'createNullableValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        return t.createNullableValuedMap();
      },
      'isSubtypeOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        D4.requireMinArgs(positional, 1, 'isSubtypeOf');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isSubtypeOf');
        return t.isSubtypeOf(other);
      },
      'isAssignableTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        D4.requireMinArgs(positional, 1, 'isAssignableTo');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isAssignableTo');
        return t.isAssignableTo(other);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypeVariableMirror>(target, 'TypeVariableMirror');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'createList': 'List<T> createList()',
      'createSet': 'Set<T> createSet()',
      'createValuedMap': 'Map<dynamic, T> createValuedMap()',
      'createKeyedMap': 'Map<T, dynamic> createKeyedMap()',
      'createKeyedValuedMap': 'Map<T, T> createKeyedValuedMap()',
      'isInstanceOf': 'bool isInstanceOf(Object? object)',
      'isSubtype': 'bool isSubtype()',
      'createNullableList': 'List<T> createNullableList()',
      'createNullableSet': 'Set<T> createNullableSet()',
      'createNullableValuedMap': 'Map<dynamic, T> createNullableValuedMap()',
      'isSubtypeOf': 'bool isSubtypeOf(TypeMirror<dynamic> other)',
      'isAssignableTo': 'bool isAssignableTo(TypeMirror<dynamic> other)',
    },
    getterSignatures: {
      'reflectedGenericType': 'Type get reflectedGenericType',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'typeVariables': 'List<TypeVariableMirror<dynamic>> get typeVariables',
      'typeArguments': 'List<TypeMirror<dynamic>> get typeArguments',
      'reflectedTypeArguments': 'List<Type> get reflectedTypeArguments',
      'isOriginalDeclaration': 'bool get isOriginalDeclaration',
      'originalDeclaration': 'TypeMirror<dynamic> get originalDeclaration',
      'isNullable': 'bool get isNullable',
      'isNonNullable': 'bool get isNonNullable',
      'isPotentiallyNullable': 'bool get isPotentiallyNullable',
      'isPotentiallyNonNullable': 'bool get isPotentiallyNonNullable',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'owner': 'DeclarationMirror? get owner',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
      'upperBound': 'TypeMirror get upperBound',
      'isStatic': 'bool get isStatic',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// TypedefMirror Bridge
// =============================================================================

BridgedClass _createTypedefMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.TypedefMirror,
    name: 'TypedefMirror',
    constructors: {
    },
    getters: {
      'referent': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').referent,
      'reflectedGenericType': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').reflectedGenericType,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').reflectedType,
      'typeVariables': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').typeVariables,
      'typeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').typeArguments,
      'reflectedTypeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').reflectedTypeArguments,
      'isOriginalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').isOriginalDeclaration,
      'originalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').originalDeclaration,
      'isNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').isNullable,
      'isNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').isNonNullable,
      'isPotentiallyNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').isPotentiallyNullable,
      'isPotentiallyNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').isPotentiallyNonNullable,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').qualifiedName,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').owner,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror').metadata,
    },
    methods: {
      'createList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        return t.createList();
      },
      'createSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        return t.createSet();
      },
      'createValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        return t.createValuedMap();
      },
      'createKeyedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        return t.createKeyedMap();
      },
      'createKeyedValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        return t.createKeyedValuedMap();
      },
      'isInstanceOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        D4.requireMinArgs(positional, 1, 'isInstanceOf');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'isInstanceOf');
        return t.isInstanceOf(object);
      },
      'isSubtype': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        return t.isSubtype();
      },
      'createNullableList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        return t.createNullableList();
      },
      'createNullableSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        return t.createNullableSet();
      },
      'createNullableValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        return t.createNullableValuedMap();
      },
      'isSubtypeOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        D4.requireMinArgs(positional, 1, 'isSubtypeOf');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isSubtypeOf');
        return t.isSubtypeOf(other);
      },
      'isAssignableTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.TypedefMirror>(target, 'TypedefMirror');
        D4.requireMinArgs(positional, 1, 'isAssignableTo');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isAssignableTo');
        return t.isAssignableTo(other);
      },
    },
    methodSignatures: {
      'createList': 'List<T> createList()',
      'createSet': 'Set<T> createSet()',
      'createValuedMap': 'Map<dynamic, T> createValuedMap()',
      'createKeyedMap': 'Map<T, dynamic> createKeyedMap()',
      'createKeyedValuedMap': 'Map<T, T> createKeyedValuedMap()',
      'isInstanceOf': 'bool isInstanceOf(Object? object)',
      'isSubtype': 'bool isSubtype()',
      'createNullableList': 'List<T> createNullableList()',
      'createNullableSet': 'Set<T> createNullableSet()',
      'createNullableValuedMap': 'Map<dynamic, T> createNullableValuedMap()',
      'isSubtypeOf': 'bool isSubtypeOf(TypeMirror<dynamic> other)',
      'isAssignableTo': 'bool isAssignableTo(TypeMirror<dynamic> other)',
    },
    getterSignatures: {
      'referent': 'FunctionTypeMirror get referent',
      'reflectedGenericType': 'Type get reflectedGenericType',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'typeVariables': 'List<TypeVariableMirror<dynamic>> get typeVariables',
      'typeArguments': 'List<TypeMirror<dynamic>> get typeArguments',
      'reflectedTypeArguments': 'List<Type> get reflectedTypeArguments',
      'isOriginalDeclaration': 'bool get isOriginalDeclaration',
      'originalDeclaration': 'TypeMirror<dynamic> get originalDeclaration',
      'isNullable': 'bool get isNullable',
      'isNonNullable': 'bool get isNonNullable',
      'isPotentiallyNullable': 'bool get isPotentiallyNullable',
      'isPotentiallyNonNullable': 'bool get isPotentiallyNonNullable',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'owner': 'DeclarationMirror? get owner',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
    },
  );
}

// =============================================================================
// MethodMirror Bridge
// =============================================================================

BridgedClass _createMethodMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.MethodMirror,
    name: 'MethodMirror',
    constructors: {
    },
    getters: {
      'returnType': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').returnType,
      'hasReflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').hasReflectedReturnType,
      'reflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').reflectedReturnType,
      'hasDynamicReflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').hasDynamicReflectedReturnType,
      'dynamicReflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').dynamicReflectedReturnType,
      'source': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').source,
      'parameters': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').parameters,
      'isStatic': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isStatic,
      'isAbstract': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isAbstract,
      'isSynthetic': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isSynthetic,
      'isRegularMethod': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isRegularMethod,
      'isOperator': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isOperator,
      'isGetter': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isGetter,
      'isSetter': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isSetter,
      'isConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isConstructor,
      'constructorName': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').constructorName,
      'isConstConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isConstConstructor,
      'isGenerativeConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isGenerativeConstructor,
      'isRedirectingConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isRedirectingConstructor,
      'isFactoryConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isFactoryConstructor,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').hashCode,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').owner,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').qualifiedName,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror').metadata,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.MethodMirror>(target, 'MethodMirror');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    getterSignatures: {
      'returnType': 'TypeMirror get returnType',
      'hasReflectedReturnType': 'bool get hasReflectedReturnType',
      'reflectedReturnType': 'Type get reflectedReturnType',
      'hasDynamicReflectedReturnType': 'bool get hasDynamicReflectedReturnType',
      'dynamicReflectedReturnType': 'Type get dynamicReflectedReturnType',
      'source': 'String? get source',
      'parameters': 'List<ParameterMirror> get parameters',
      'isStatic': 'bool get isStatic',
      'isAbstract': 'bool get isAbstract',
      'isSynthetic': 'bool get isSynthetic',
      'isRegularMethod': 'bool get isRegularMethod',
      'isOperator': 'bool get isOperator',
      'isGetter': 'bool get isGetter',
      'isSetter': 'bool get isSetter',
      'isConstructor': 'bool get isConstructor',
      'constructorName': 'String get constructorName',
      'isConstConstructor': 'bool get isConstConstructor',
      'isGenerativeConstructor': 'bool get isGenerativeConstructor',
      'isRedirectingConstructor': 'bool get isRedirectingConstructor',
      'isFactoryConstructor': 'bool get isFactoryConstructor',
      'hashCode': 'int get hashCode',
      'owner': 'DeclarationMirror get owner',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
    },
  );
}

// =============================================================================
// VariableMirror Bridge
// =============================================================================

BridgedClass _createVariableMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.VariableMirror,
    name: 'VariableMirror',
    constructors: {
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').type,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').reflectedType,
      'hasDynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').hasDynamicReflectedType,
      'dynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').dynamicReflectedType,
      'isStatic': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').isStatic,
      'isFinal': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').isFinal,
      'isConst': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').isConst,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').hashCode,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').owner,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').qualifiedName,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror').metadata,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.VariableMirror>(target, 'VariableMirror');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    getterSignatures: {
      'type': 'TypeMirror get type',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'hasDynamicReflectedType': 'bool get hasDynamicReflectedType',
      'dynamicReflectedType': 'Type get dynamicReflectedType',
      'isStatic': 'bool get isStatic',
      'isFinal': 'bool get isFinal',
      'isConst': 'bool get isConst',
      'hashCode': 'int get hashCode',
      'owner': 'DeclarationMirror get owner',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
    },
  );
}

// =============================================================================
// ParameterMirror Bridge
// =============================================================================

BridgedClass _createParameterMirrorBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.ParameterMirror,
    name: 'ParameterMirror',
    constructors: {
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').type,
      'isOptional': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').isOptional,
      'isNamed': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').isNamed,
      'hasDefaultValue': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').hasDefaultValue,
      'defaultValue': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').defaultValue,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').reflectedType,
      'hasDynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').hasDynamicReflectedType,
      'dynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').dynamicReflectedType,
      'isStatic': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').isStatic,
      'isFinal': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').isFinal,
      'isConst': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').isConst,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').hashCode,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').owner,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').qualifiedName,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror').metadata,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_2.ParameterMirror>(target, 'ParameterMirror');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    getterSignatures: {
      'type': 'TypeMirror get type',
      'isOptional': 'bool get isOptional',
      'isNamed': 'bool get isNamed',
      'hasDefaultValue': 'bool get hasDefaultValue',
      'defaultValue': 'Object? get defaultValue',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'hasDynamicReflectedType': 'bool get hasDynamicReflectedType',
      'dynamicReflectedType': 'Type get dynamicReflectedType',
      'isStatic': 'bool get isStatic',
      'isFinal': 'bool get isFinal',
      'isConst': 'bool get isConst',
      'hashCode': 'int get hashCode',
      'owner': 'DeclarationMirror get owner',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
    },
  );
}

// =============================================================================
// SourceLocation Bridge
// =============================================================================

BridgedClass _createSourceLocationBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.SourceLocation,
    name: 'SourceLocation',
    constructors: {
    },
    getters: {
      'line': (visitor, target) => D4.validateTarget<$tom_reflection_2.SourceLocation>(target, 'SourceLocation').line,
      'column': (visitor, target) => D4.validateTarget<$tom_reflection_2.SourceLocation>(target, 'SourceLocation').column,
      'sourceUri': (visitor, target) => D4.validateTarget<$tom_reflection_2.SourceLocation>(target, 'SourceLocation').sourceUri,
    },
    getterSignatures: {
      'line': 'int get line',
      'column': 'int get column',
      'sourceUri': 'Uri get sourceUri',
    },
  );
}

// =============================================================================
// Comment Bridge
// =============================================================================

BridgedClass _createCommentBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.Comment,
    name: 'Comment',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Comment');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'Comment');
        final trimmedText = D4.getRequiredArg<String>(positional, 1, 'trimmedText', 'Comment');
        final isDocComment = D4.getRequiredArg<bool>(positional, 2, 'isDocComment', 'Comment');
        return $tom_reflection_2.Comment(text, trimmedText, isDocComment);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$tom_reflection_2.Comment>(target, 'Comment').text,
      'trimmedText': (visitor, target) => D4.validateTarget<$tom_reflection_2.Comment>(target, 'Comment').trimmedText,
      'isDocComment': (visitor, target) => D4.validateTarget<$tom_reflection_2.Comment>(target, 'Comment').isDocComment,
    },
    constructorSignatures: {
      '': 'const Comment(String text, String trimmedText, bool isDocComment)',
    },
    getterSignatures: {
      'text': 'String get text',
      'trimmedText': 'String get trimmedText',
      'isDocComment': 'bool get isDocComment',
    },
  );
}

// =============================================================================
// TypeValue Bridge
// =============================================================================

BridgedClass _createTypeValueBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_2.TypeValue,
    name: 'TypeValue',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_reflection_2.TypeValue();
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_reflection_2.TypeValue>(target, 'TypeValue').type,
    },
    constructorSignatures: {
      '': 'const TypeValue()',
    },
    getterSignatures: {
      'type': 'Type get type',
    },
  );
}

// =============================================================================
// ReflectionInterface Bridge
// =============================================================================

BridgedClass _createReflectionInterfaceBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_4.ReflectionInterface,
    name: 'ReflectionInterface',
    constructors: {
    },
    getters: {
      'libraries': (visitor, target) => D4.validateTarget<$tom_reflection_4.ReflectionInterface>(target, 'ReflectionInterface').libraries,
      'annotatedClasses': (visitor, target) => D4.validateTarget<$tom_reflection_4.ReflectionInterface>(target, 'ReflectionInterface').annotatedClasses,
    },
    methods: {
      'canReflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.ReflectionInterface>(target, 'ReflectionInterface');
        D4.requireMinArgs(positional, 1, 'canReflect');
        final o = D4.getRequiredArg<Object>(positional, 0, 'o', 'canReflect');
        return t.canReflect(o);
      },
      'reflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.ReflectionInterface>(target, 'ReflectionInterface');
        D4.requireMinArgs(positional, 1, 'reflect');
        final o = D4.getRequiredArg<Object>(positional, 0, 'o', 'reflect');
        return t.reflect(o);
      },
      'canReflectType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.ReflectionInterface>(target, 'ReflectionInterface');
        D4.requireMinArgs(positional, 1, 'canReflectType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'canReflectType');
        return t.canReflectType(type);
      },
      'reflectType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.ReflectionInterface>(target, 'ReflectionInterface');
        D4.requireMinArgs(positional, 1, 'reflectType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'reflectType');
        return t.reflectType(type);
      },
      'findLibrary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.ReflectionInterface>(target, 'ReflectionInterface');
        D4.requireMinArgs(positional, 1, 'findLibrary');
        final library = D4.getRequiredArg<String>(positional, 0, 'library', 'findLibrary');
        return t.findLibrary(library);
      },
    },
    methodSignatures: {
      'canReflect': 'bool canReflect(Object o)',
      'reflect': 'InstanceMirror reflect(Object o)',
      'canReflectType': 'bool canReflectType(Type type)',
      'reflectType': 'TypeMirror reflectType(Type type)',
      'findLibrary': 'LibraryMirror findLibrary(String library)',
    },
    getterSignatures: {
      'libraries': 'Map<Uri, LibraryMirror> get libraries',
      'annotatedClasses': 'Iterable<ClassMirror> get annotatedClasses',
    },
  );
}

// =============================================================================
// Reflection Bridge
// =============================================================================

BridgedClass _createReflectionBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_4.Reflection,
    name: 'Reflection',
    constructors: {
    },
    getters: {
      'libraries': (visitor, target) => D4.validateTarget<$tom_reflection_4.Reflection>(target, 'Reflection').libraries,
      'annotatedClasses': (visitor, target) => D4.validateTarget<$tom_reflection_4.Reflection>(target, 'Reflection').annotatedClasses,
      'capabilities': (visitor, target) => D4.validateTarget<$tom_reflection_4.Reflection>(target, 'Reflection').capabilities,
    },
    methods: {
      'canReflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.Reflection>(target, 'Reflection');
        D4.requireMinArgs(positional, 1, 'canReflect');
        final reflectee = D4.getRequiredArg<Object>(positional, 0, 'reflectee', 'canReflect');
        return t.canReflect(reflectee);
      },
      'reflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.Reflection>(target, 'Reflection');
        D4.requireMinArgs(positional, 1, 'reflect');
        final reflectee = D4.getRequiredArg<Object>(positional, 0, 'reflectee', 'reflect');
        return t.reflect(reflectee);
      },
      'canReflectType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.Reflection>(target, 'Reflection');
        D4.requireMinArgs(positional, 1, 'canReflectType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'canReflectType');
        return t.canReflectType(type);
      },
      'reflectType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.Reflection>(target, 'Reflection');
        D4.requireMinArgs(positional, 1, 'reflectType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'reflectType');
        return t.reflectType(type);
      },
      'findLibrary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_4.Reflection>(target, 'Reflection');
        D4.requireMinArgs(positional, 1, 'findLibrary');
        final libraryName = D4.getRequiredArg<String>(positional, 0, 'libraryName', 'findLibrary');
        return t.findLibrary(libraryName);
      },
    },
    staticGetters: {
      'thisClassName': (visitor) => $tom_reflection_4.Reflection.thisClassName,
      'thisClassId': (visitor) => $tom_reflection_4.Reflection.thisClassId,
    },
    staticMethods: {
      'getInstance': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getInstance');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'getInstance');
        return $tom_reflection_4.Reflection.getInstance(type);
      },
    },
    methodSignatures: {
      'canReflect': 'bool canReflect(Object reflectee)',
      'reflect': 'InstanceMirror reflect(Object reflectee)',
      'canReflectType': 'bool canReflectType(Type type)',
      'reflectType': 'TypeMirror<dynamic> reflectType(Type type)',
      'findLibrary': 'LibraryMirror findLibrary(String libraryName)',
    },
    getterSignatures: {
      'libraries': 'Map<Uri, LibraryMirror> get libraries',
      'annotatedClasses': 'Iterable<ClassMirror<dynamic>> get annotatedClasses',
      'capabilities': 'List<ReflectCapability> get capabilities',
    },
    staticMethodSignatures: {
      'getInstance': 'Reflection? getInstance(Type type)',
    },
    staticGetterSignatures: {
      'thisClassName': 'dynamic get thisClassName',
      'thisClassId': 'dynamic get thisClassId',
    },
  );
}

// =============================================================================
// StringInvocation Bridge
// =============================================================================

BridgedClass _createStringInvocationBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_4.StringInvocation,
    name: 'StringInvocation',
    constructors: {
    },
    getters: {
      'memberName': (visitor, target) => D4.validateTarget<$tom_reflection_4.StringInvocation>(target, 'StringInvocation').memberName,
      'positionalArguments': (visitor, target) => D4.validateTarget<$tom_reflection_4.StringInvocation>(target, 'StringInvocation').positionalArguments,
      'namedArguments': (visitor, target) => D4.validateTarget<$tom_reflection_4.StringInvocation>(target, 'StringInvocation').namedArguments,
      'isMethod': (visitor, target) => D4.validateTarget<$tom_reflection_4.StringInvocation>(target, 'StringInvocation').isMethod,
      'isGetter': (visitor, target) => D4.validateTarget<$tom_reflection_4.StringInvocation>(target, 'StringInvocation').isGetter,
      'isSetter': (visitor, target) => D4.validateTarget<$tom_reflection_4.StringInvocation>(target, 'StringInvocation').isSetter,
      'isAccessor': (visitor, target) => D4.validateTarget<$tom_reflection_4.StringInvocation>(target, 'StringInvocation').isAccessor,
    },
    getterSignatures: {
      'memberName': 'String get memberName',
      'positionalArguments': 'List get positionalArguments',
      'namedArguments': 'Map<Symbol, dynamic> get namedArguments',
      'isMethod': 'bool get isMethod',
      'isGetter': 'bool get isGetter',
      'isSetter': 'bool get isSetter',
      'isAccessor': 'bool get isAccessor',
    },
  );
}

// =============================================================================
// ReflectorData Bridge
// =============================================================================

BridgedClass _createReflectorDataBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_3.ReflectorData,
    name: 'ReflectorData',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 9, 'ReflectorData');
        if (positional.isEmpty) {
          throw ArgumentError('ReflectorData: Missing required argument "typeMirrors" at position 0');
        }
        final typeMirrors = D4.coerceList<$tom_reflection_2.TypeMirror<dynamic>>(positional[0], 'typeMirrors');
        if (positional.length <= 1) {
          throw ArgumentError('ReflectorData: Missing required argument "memberMirrors" at position 1');
        }
        final memberMirrors = D4.coerceListOrNull<$tom_reflection_2.DeclarationMirror>(positional[1], 'memberMirrors');
        if (positional.length <= 2) {
          throw ArgumentError('ReflectorData: Missing required argument "parameterMirrors" at position 2');
        }
        final parameterMirrors = D4.coerceListOrNull<$tom_reflection_2.ParameterMirror>(positional[2], 'parameterMirrors');
        if (positional.length <= 3) {
          throw ArgumentError('ReflectorData: Missing required argument "types" at position 3');
        }
        final types = D4.coerceList<Type>(positional[3], 'types');
        final supportedClassCount = D4.getRequiredArg<int>(positional, 4, 'supportedClassCount', 'ReflectorData');
        if (positional.length <= 5) {
          throw ArgumentError('ReflectorData: Missing required argument "getters" at position 5');
        }
        final getters = D4.coerceMap<String, Object? Function(Object?)>(positional[5], 'getters');
        if (positional.length <= 6) {
          throw ArgumentError('ReflectorData: Missing required argument "setters" at position 6');
        }
        final setters = D4.coerceMap<String, Object? Function(Object?, Object?)>(positional[6], 'setters');
        if (positional.length <= 7) {
          throw ArgumentError('ReflectorData: Missing required argument "libraryMirrors" at position 7');
        }
        final libraryMirrors = D4.coerceListOrNull<$tom_reflection_2.LibraryMirror>(positional[7], 'libraryMirrors');
        if (positional.length <= 8) {
          throw ArgumentError('ReflectorData: Missing required argument "parameterListShapes" at position 8');
        }
        final parameterListShapes = D4.coerceListOrNull<List<dynamic>>(positional[8], 'parameterListShapes');
        return $tom_reflection_3.ReflectorData(typeMirrors, memberMirrors, parameterMirrors, types, supportedClassCount, getters, setters, libraryMirrors, parameterListShapes);
      },
    },
    getters: {
      'typeMirrors': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData').typeMirrors,
      'libraryMirrors': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData').libraryMirrors,
      'memberMirrors': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData').memberMirrors,
      'parameterMirrors': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData').parameterMirrors,
      'types': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData').types,
      'supportedClassCount': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData').supportedClassCount,
      'getters': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData').getters,
      'setters': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData').setters,
      'parameterListShapes': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData').parameterListShapes,
    },
    methods: {
      'typeMirrorForType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData');
        D4.requireMinArgs(positional, 1, 'typeMirrorForType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'typeMirrorForType');
        return t.typeMirrorForType(type);
      },
      'classMirrorForInstance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ReflectorData>(target, 'ReflectorData');
        D4.requireMinArgs(positional, 1, 'classMirrorForInstance');
        final instance = D4.getRequiredArg<Object?>(positional, 0, 'instance', 'classMirrorForInstance');
        return t.classMirrorForInstance(instance);
      },
    },
    constructorSignatures: {
      '': 'ReflectorData(List<TypeMirror<dynamic>> typeMirrors, List<DeclarationMirror>? memberMirrors, List<ParameterMirror>? parameterMirrors, List<Type> types, int supportedClassCount, Map<String, Object? Function(Object?)> getters, Map<String, Object? Function(Object?, Object?)> setters, List<LibraryMirror>? libraryMirrors, List<List<dynamic>>? parameterListShapes)',
    },
    methodSignatures: {
      'typeMirrorForType': 'TypeMirror? typeMirrorForType(Type type)',
      'classMirrorForInstance': 'ClassMirror? classMirrorForInstance(Object? instance)',
    },
    getterSignatures: {
      'typeMirrors': 'List<TypeMirror> get typeMirrors',
      'libraryMirrors': 'List<LibraryMirror>? get libraryMirrors',
      'memberMirrors': 'List<DeclarationMirror>? get memberMirrors',
      'parameterMirrors': 'List<ParameterMirror>? get parameterMirrors',
      'types': 'List<Type> get types',
      'supportedClassCount': 'int get supportedClassCount',
      'getters': 'Map<String, InvokerOfGetter> get getters',
      'setters': 'Map<String, InvokerOfSetter> get setters',
      'parameterListShapes': 'List<List>? get parameterListShapes',
    },
  );
}

// =============================================================================
// NonGenericClassMirrorImpl Bridge
// =============================================================================

BridgedClass _createNonGenericClassMirrorImplBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_3.NonGenericClassMirrorImpl,
    name: 'NonGenericClassMirrorImpl',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 17, 'NonGenericClassMirrorImpl');
        final simpleName = D4.getRequiredArg<String>(positional, 0, 'simpleName', 'NonGenericClassMirrorImpl');
        final qualifiedName = D4.getRequiredArg<String>(positional, 1, 'qualifiedName', 'NonGenericClassMirrorImpl');
        final descriptor = D4.getRequiredArg<int>(positional, 2, 'descriptor', 'NonGenericClassMirrorImpl');
        final classIndex = D4.getRequiredArg<int>(positional, 3, 'classIndex', 'NonGenericClassMirrorImpl');
        final reflector = D4.getRequiredArg<$tom_reflection_3.ReflectionImpl>(positional, 4, 'reflector', 'NonGenericClassMirrorImpl');
        if (positional.length <= 5) {
          throw ArgumentError('NonGenericClassMirrorImpl: Missing required argument "declarationIndices" at position 5');
        }
        final declarationIndices = D4.coerceList<int>(positional[5], 'declarationIndices');
        if (positional.length <= 6) {
          throw ArgumentError('NonGenericClassMirrorImpl: Missing required argument "instanceMemberIndices" at position 6');
        }
        final instanceMemberIndices = D4.coerceListOrNull<int>(positional[6], 'instanceMemberIndices');
        if (positional.length <= 7) {
          throw ArgumentError('NonGenericClassMirrorImpl: Missing required argument "staticMemberIndices" at position 7');
        }
        final staticMemberIndices = D4.coerceListOrNull<int>(positional[7], 'staticMemberIndices');
        final superclassIndex = D4.getRequiredArg<int?>(positional, 8, 'superclassIndex', 'NonGenericClassMirrorImpl');
        if (positional.length <= 9) {
          throw ArgumentError('NonGenericClassMirrorImpl: Missing required argument "getters" at position 9');
        }
        final getters = D4.coerceMap<String, Object? Function()>(positional[9], 'getters');
        if (positional.length <= 10) {
          throw ArgumentError('NonGenericClassMirrorImpl: Missing required argument "setters" at position 10');
        }
        final setters = D4.coerceMap<String, Object? Function(Object?)>(positional[10], 'setters');
        if (positional.length <= 11) {
          throw ArgumentError('NonGenericClassMirrorImpl: Missing required argument "constructors" at position 11');
        }
        final constructors = D4.coerceMap<String, Function>(positional[11], 'constructors');
        final ownerIndex = D4.getRequiredArg<int>(positional, 12, 'ownerIndex', 'NonGenericClassMirrorImpl');
        final mixinIndex = D4.getRequiredArg<int>(positional, 13, 'mixinIndex', 'NonGenericClassMirrorImpl');
        if (positional.length <= 14) {
          throw ArgumentError('NonGenericClassMirrorImpl: Missing required argument "superinterfaceIndices" at position 14');
        }
        final superinterfaceIndices = D4.coerceList<int>(positional[14], 'superinterfaceIndices');
        if (positional.length <= 15) {
          throw ArgumentError('NonGenericClassMirrorImpl: Missing required argument "metadata" at position 15');
        }
        final metadata = D4.coerceListOrNull<Object>(positional[15], 'metadata');
        if (positional.length <= 16) {
          throw ArgumentError('NonGenericClassMirrorImpl: Missing required argument "parameterListShapes" at position 16');
        }
        final parameterListShapes = D4.coerceMapOrNull<String, int>(positional[16], 'parameterListShapes');
        return $tom_reflection_3.NonGenericClassMirrorImpl(simpleName, qualifiedName, descriptor, classIndex, reflector, declarationIndices, instanceMemberIndices, staticMemberIndices, superclassIndex, getters, setters, constructors, ownerIndex, mixinIndex, superinterfaceIndices, metadata, parameterListShapes);
      },
    },
    getters: {
      'typeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').typeArguments,
      'reflectedTypeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').reflectedTypeArguments,
      'typeVariables': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').typeVariables,
      'isOriginalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').isOriginalDeclaration,
      'originalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').originalDeclaration,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').reflectedType,
      'hasDynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').hasDynamicReflectedType,
      'dynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').dynamicReflectedType,
      'reflectedGenericType': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').reflectedGenericType,
      'superinterfaces': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').superinterfaces,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').qualifiedName,
      'isAbstract': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').isAbstract,
      'declarations': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').declarations,
      'instanceMembers': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').instanceMembers,
      'staticMembers': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').staticMembers,
      'mixin': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').mixin,
      'isEnum': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').isEnum,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').isPrivate,
      'isNullable': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').isNullable,
      'isNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').isNonNullable,
      'isPotentiallyNullable': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').isPotentiallyNullable,
      'isPotentiallyNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').isPotentiallyNonNullable,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').metadata,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').owner,
      'superclass': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').superclass,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.toString();
      },
      'createList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.createList();
      },
      'createSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.createSet();
      },
      'createValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.createValuedMap();
      },
      'createKeyedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.createKeyedMap();
      },
      'createKeyedValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.createKeyedValuedMap();
      },
      'isInstanceOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'isInstanceOf');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'isInstanceOf');
        return t.isInstanceOf(object);
      },
      'isSubtype': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.isSubtype();
      },
      'createNullableList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.createNullableList();
      },
      'createNullableSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.createNullableSet();
      },
      'createNullableValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        return t.createNullableValuedMap();
      },
      'newInstance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        D4.requireMinArgs(positional, 2, 'newInstance');
        final constructorName = D4.getRequiredArg<String>(positional, 0, 'constructorName', 'newInstance');
        if (positional.length <= 1) {
          throw ArgumentError('newInstance: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMap<Symbol, dynamic>(positional[2], 'namedArguments')
            : <Symbol, dynamic>{};
        return t.newInstance(constructorName, positionalArguments, namedArguments);
      },
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        D4.requireMinArgs(positional, 2, 'invoke');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoke');
        if (positional.length <= 1) {
          throw ArgumentError('invoke: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMap<Symbol, dynamic>(positional[2], 'namedArguments')
            : <Symbol, dynamic>{};
        return t.invoke(memberName, positionalArguments, namedArguments);
      },
      'invokeGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'invokeGetter');
        final getterName = D4.getRequiredArg<String>(positional, 0, 'getterName', 'invokeGetter');
        return t.invokeGetter(getterName);
      },
      'invokeSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        D4.requireMinArgs(positional, 2, 'invokeSetter');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeSetter');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'invokeSetter');
        return t.invokeSetter(name, value);
      },
      'invoker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'invoker');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoker');
        return t.invoker(memberName);
      },
      'isAssignableTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'isAssignableTo');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isAssignableTo');
        return t.isAssignableTo(other);
      },
      'isSubtypeOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'isSubtypeOf');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isSubtypeOf');
        return t.isSubtypeOf(other);
      },
      'isSubclassOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'isSubclassOf');
        final other = D4.getRequiredArg<$tom_reflection_2.ClassMirror<dynamic>>(positional, 0, 'other', 'isSubclassOf');
        return t.isSubclassOf(other);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.NonGenericClassMirrorImpl>(target, 'NonGenericClassMirrorImpl');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'NonGenericClassMirrorImpl(String simpleName, String qualifiedName, int descriptor, int classIndex, ReflectionImpl reflector, List<int> declarationIndices, List<int>? instanceMemberIndices, List<int>? staticMemberIndices, int? superclassIndex, Map<String, Object? Function()> getters, Map<String, Object? Function(Object?)> setters, Map<String, Function> constructors, int ownerIndex, int mixinIndex, List<int> superinterfaceIndices, List<Object>? metadata, Map<String, int>? parameterListShapes)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'createList': 'List<T> createList()',
      'createSet': 'Set<T> createSet()',
      'createValuedMap': 'Map<dynamic, T> createValuedMap()',
      'createKeyedMap': 'Map<T, dynamic> createKeyedMap()',
      'createKeyedValuedMap': 'Map<T, T> createKeyedValuedMap()',
      'isInstanceOf': 'bool isInstanceOf(Object? object)',
      'isSubtype': 'bool isSubtype()',
      'createNullableList': 'List<T> createNullableList()',
      'createNullableSet': 'Set<T> createNullableSet()',
      'createNullableValuedMap': 'Map<dynamic, T> createNullableValuedMap()',
      'newInstance': 'Object newInstance(String constructorName, List<dynamic> positionalArguments, [Map<Symbol, dynamic> namedArguments])',
      'invoke': 'Object? invoke(String memberName, List<dynamic> positionalArguments, [Map<Symbol, dynamic> namedArguments])',
      'invokeGetter': 'Object? invokeGetter(String getterName)',
      'invokeSetter': 'Object? invokeSetter(String name, Object? value)',
      'invoker': 'Function invoker(String memberName)',
      'isAssignableTo': 'bool isAssignableTo(TypeMirror<dynamic> other)',
      'isSubtypeOf': 'bool isSubtypeOf(TypeMirror<dynamic> other)',
      'isSubclassOf': 'bool isSubclassOf(ClassMirror<dynamic> other)',
    },
    getterSignatures: {
      'typeArguments': 'List<TypeMirror> get typeArguments',
      'reflectedTypeArguments': 'List<Type> get reflectedTypeArguments',
      'typeVariables': 'List<TypeVariableMirror> get typeVariables',
      'isOriginalDeclaration': 'bool get isOriginalDeclaration',
      'originalDeclaration': 'TypeMirror get originalDeclaration',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'hasDynamicReflectedType': 'bool get hasDynamicReflectedType',
      'dynamicReflectedType': 'Type get dynamicReflectedType',
      'reflectedGenericType': 'Type get reflectedGenericType',
      'superinterfaces': 'List<ClassMirror<dynamic>> get superinterfaces',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'isAbstract': 'bool get isAbstract',
      'declarations': 'Map<String, DeclarationMirror> get declarations',
      'instanceMembers': 'Map<String, MethodMirror> get instanceMembers',
      'staticMembers': 'Map<String, MethodMirror> get staticMembers',
      'mixin': 'ClassMirror<dynamic> get mixin',
      'isEnum': 'bool get isEnum',
      'isPrivate': 'bool get isPrivate',
      'isNullable': 'bool get isNullable',
      'isNonNullable': 'bool get isNonNullable',
      'isPotentiallyNullable': 'bool get isPotentiallyNullable',
      'isPotentiallyNonNullable': 'bool get isPotentiallyNonNullable',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
      'owner': 'DeclarationMirror get owner',
      'superclass': 'ClassMirrorBase<Object> get superclass',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// GenericClassMirrorImpl Bridge
// =============================================================================

BridgedClass _createGenericClassMirrorImplBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_3.GenericClassMirrorImpl,
    name: 'GenericClassMirrorImpl',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 20, 'GenericClassMirrorImpl');
        final simpleName = D4.getRequiredArg<String>(positional, 0, 'simpleName', 'GenericClassMirrorImpl');
        final qualifiedName = D4.getRequiredArg<String>(positional, 1, 'qualifiedName', 'GenericClassMirrorImpl');
        final descriptor = D4.getRequiredArg<int>(positional, 2, 'descriptor', 'GenericClassMirrorImpl');
        final classIndex = D4.getRequiredArg<int>(positional, 3, 'classIndex', 'GenericClassMirrorImpl');
        final reflector = D4.getRequiredArg<$tom_reflection_3.ReflectionImpl>(positional, 4, 'reflector', 'GenericClassMirrorImpl');
        if (positional.length <= 5) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "declarationIndices" at position 5');
        }
        final declarationIndices = D4.coerceList<int>(positional[5], 'declarationIndices');
        if (positional.length <= 6) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "instanceMemberIndices" at position 6');
        }
        final instanceMemberIndices = D4.coerceListOrNull<int>(positional[6], 'instanceMemberIndices');
        if (positional.length <= 7) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "staticMemberIndices" at position 7');
        }
        final staticMemberIndices = D4.coerceListOrNull<int>(positional[7], 'staticMemberIndices');
        final superclassIndex = D4.getRequiredArg<int>(positional, 8, 'superclassIndex', 'GenericClassMirrorImpl');
        if (positional.length <= 9) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "getters" at position 9');
        }
        final getters = D4.coerceMap<String, Object? Function()>(positional[9], 'getters');
        if (positional.length <= 10) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "setters" at position 10');
        }
        final setters = D4.coerceMap<String, Object? Function(Object?)>(positional[10], 'setters');
        if (positional.length <= 11) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "constructors" at position 11');
        }
        final constructors = D4.coerceMap<String, Function>(positional[11], 'constructors');
        final ownerIndex = D4.getRequiredArg<int>(positional, 12, 'ownerIndex', 'GenericClassMirrorImpl');
        final mixinIndex = D4.getRequiredArg<int>(positional, 13, 'mixinIndex', 'GenericClassMirrorImpl');
        if (positional.length <= 14) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "superinterfaceIndices" at position 14');
        }
        final superinterfaceIndices = D4.coerceList<int>(positional[14], 'superinterfaceIndices');
        if (positional.length <= 15) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "metadata" at position 15');
        }
        final metadata = D4.coerceListOrNull<Object>(positional[15], 'metadata');
        if (positional.length <= 16) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "parameterListShapes" at position 16');
        }
        final parameterListShapes = D4.coerceMapOrNull<String, int>(positional[16], 'parameterListShapes');
        if (positional.length <= 17) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "_isGenericRuntimeTypeOf" at position 17');
        }
        final isGenericRuntimeTypeOfRaw = positional[17];
        if (positional.length <= 18) {
          throw ArgumentError('GenericClassMirrorImpl: Missing required argument "_typeVariableIndices" at position 18');
        }
        final typeVariableIndices = D4.coerceListOrNull<int>(positional[18], '_typeVariableIndices');
        final dynamicReflectedTypeIndex = D4.getRequiredArg<int>(positional, 19, '_dynamicReflectedTypeIndex', 'GenericClassMirrorImpl');
        return $tom_reflection_3.GenericClassMirrorImpl(simpleName, qualifiedName, descriptor, classIndex, reflector, declarationIndices, instanceMemberIndices, staticMemberIndices, superclassIndex, getters, setters, constructors, ownerIndex, mixinIndex, superinterfaceIndices, metadata, parameterListShapes, (Object? p0) { return D4.callInterpreterCallback(visitor, isGenericRuntimeTypeOfRaw, [p0]) as bool; }, typeVariableIndices, dynamicReflectedTypeIndex);
      },
    },
    getters: {
      'typeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').typeArguments,
      'reflectedTypeArguments': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').reflectedTypeArguments,
      'typeVariables': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').typeVariables,
      'isOriginalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').isOriginalDeclaration,
      'originalDeclaration': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').originalDeclaration,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').reflectedType,
      'hasDynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').hasDynamicReflectedType,
      'dynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').dynamicReflectedType,
      'reflectedGenericType': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').reflectedGenericType,
      'superinterfaces': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').superinterfaces,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').qualifiedName,
      'isAbstract': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').isAbstract,
      'declarations': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').declarations,
      'instanceMembers': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').instanceMembers,
      'staticMembers': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').staticMembers,
      'mixin': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').mixin,
      'isEnum': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').isEnum,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').isPrivate,
      'isNullable': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').isNullable,
      'isNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').isNonNullable,
      'isPotentiallyNullable': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').isPotentiallyNullable,
      'isPotentiallyNonNullable': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').isPotentiallyNonNullable,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').metadata,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').owner,
      'superclass': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').superclass,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl').hashCode,
    },
    methods: {
      'createInstantiatedGenericClassMirror': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 2, 'createInstantiatedGenericClassMirror');
        final instance = D4.getRequiredArg<Object?>(positional, 0, 'instance', 'createInstantiatedGenericClassMirror');
        if (positional.length <= 1) {
          throw ArgumentError('createInstantiatedGenericClassMirror: Missing required argument "reflectedTypeArgumentIndices" at position 1');
        }
        final reflectedTypeArgumentIndices = D4.coerceListOrNull<int>(positional[1], 'reflectedTypeArgumentIndices');
        final descriptor = D4.getOptionalArg<int?>(positional, 2, 'descriptor');
        return t.createInstantiatedGenericClassMirror(instance, reflectedTypeArgumentIndices, descriptor);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.toString();
      },
      'createList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.createList();
      },
      'createSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.createSet();
      },
      'createValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.createValuedMap();
      },
      'createKeyedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.createKeyedMap();
      },
      'createKeyedValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.createKeyedValuedMap();
      },
      'isInstanceOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'isInstanceOf');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'isInstanceOf');
        return t.isInstanceOf(object);
      },
      'isSubtype': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.isSubtype();
      },
      'createNullableList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.createNullableList();
      },
      'createNullableSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.createNullableSet();
      },
      'createNullableValuedMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        return t.createNullableValuedMap();
      },
      'newInstance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 2, 'newInstance');
        final constructorName = D4.getRequiredArg<String>(positional, 0, 'constructorName', 'newInstance');
        if (positional.length <= 1) {
          throw ArgumentError('newInstance: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMap<Symbol, dynamic>(positional[2], 'namedArguments')
            : <Symbol, dynamic>{};
        return t.newInstance(constructorName, positionalArguments, namedArguments);
      },
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 2, 'invoke');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoke');
        if (positional.length <= 1) {
          throw ArgumentError('invoke: Missing required argument "positionalArguments" at position 1');
        }
        final positionalArguments = D4.coerceList<dynamic>(positional[1], 'positionalArguments');
        final namedArguments = positional.length > 2
            ? D4.coerceMap<Symbol, dynamic>(positional[2], 'namedArguments')
            : <Symbol, dynamic>{};
        return t.invoke(memberName, positionalArguments, namedArguments);
      },
      'invokeGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'invokeGetter');
        final getterName = D4.getRequiredArg<String>(positional, 0, 'getterName', 'invokeGetter');
        return t.invokeGetter(getterName);
      },
      'invokeSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 2, 'invokeSetter');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeSetter');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'invokeSetter');
        return t.invokeSetter(name, value);
      },
      'invoker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'invoker');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoker');
        return t.invoker(memberName);
      },
      'isAssignableTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'isAssignableTo');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isAssignableTo');
        return t.isAssignableTo(other);
      },
      'isSubtypeOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'isSubtypeOf');
        final other = D4.getRequiredArg<$tom_reflection_2.TypeMirror<dynamic>>(positional, 0, 'other', 'isSubtypeOf');
        return t.isSubtypeOf(other);
      },
      'isSubclassOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        D4.requireMinArgs(positional, 1, 'isSubclassOf');
        final other = D4.getRequiredArg<$tom_reflection_2.ClassMirror<dynamic>>(positional, 0, 'other', 'isSubclassOf');
        return t.isSubclassOf(other);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.GenericClassMirrorImpl>(target, 'GenericClassMirrorImpl');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'GenericClassMirrorImpl(String simpleName, String qualifiedName, int descriptor, int classIndex, ReflectionImpl reflector, List<int> declarationIndices, List<int>? instanceMemberIndices, List<int>? staticMemberIndices, int superclassIndex, Map<String, Object? Function()> getters, Map<String, Object? Function(Object?)> setters, Map<String, Function> constructors, int ownerIndex, int mixinIndex, List<int> superinterfaceIndices, List<Object>? metadata, Map<String, int>? parameterListShapes, bool Function(Object?) _isGenericRuntimeTypeOf, List<int>? _typeVariableIndices, int _dynamicReflectedTypeIndex)',
    },
    methodSignatures: {
      'createInstantiatedGenericClassMirror': 'InstantiatedGenericClassMirrorImpl<T> createInstantiatedGenericClassMirror(Object? instance, List<int>? reflectedTypeArgumentIndices, [int? descriptor])',
      'toString': 'String toString()',
      'createList': 'List<T> createList()',
      'createSet': 'Set<T> createSet()',
      'createValuedMap': 'Map<dynamic, T> createValuedMap()',
      'createKeyedMap': 'Map<T, dynamic> createKeyedMap()',
      'createKeyedValuedMap': 'Map<T, T> createKeyedValuedMap()',
      'isInstanceOf': 'bool isInstanceOf(Object? object)',
      'isSubtype': 'bool isSubtype()',
      'createNullableList': 'List<T> createNullableList()',
      'createNullableSet': 'Set<T> createNullableSet()',
      'createNullableValuedMap': 'Map<dynamic, T> createNullableValuedMap()',
      'newInstance': 'Object newInstance(String constructorName, List<dynamic> positionalArguments, [Map<Symbol, dynamic> namedArguments])',
      'invoke': 'Object? invoke(String memberName, List<dynamic> positionalArguments, [Map<Symbol, dynamic> namedArguments])',
      'invokeGetter': 'Object? invokeGetter(String getterName)',
      'invokeSetter': 'Object? invokeSetter(String name, Object? value)',
      'invoker': 'Function invoker(String memberName)',
      'isAssignableTo': 'bool isAssignableTo(TypeMirror<dynamic> other)',
      'isSubtypeOf': 'bool isSubtypeOf(TypeMirror<dynamic> other)',
      'isSubclassOf': 'bool isSubclassOf(ClassMirror<dynamic> other)',
    },
    getterSignatures: {
      'typeArguments': 'List<TypeMirror> get typeArguments',
      'reflectedTypeArguments': 'List<Type> get reflectedTypeArguments',
      'typeVariables': 'List<TypeVariableMirror> get typeVariables',
      'isOriginalDeclaration': 'bool get isOriginalDeclaration',
      'originalDeclaration': 'TypeMirror get originalDeclaration',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'hasDynamicReflectedType': 'bool get hasDynamicReflectedType',
      'dynamicReflectedType': 'Type get dynamicReflectedType',
      'reflectedGenericType': 'Type get reflectedGenericType',
      'superinterfaces': 'List<ClassMirror<dynamic>> get superinterfaces',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'isAbstract': 'bool get isAbstract',
      'declarations': 'Map<String, DeclarationMirror> get declarations',
      'instanceMembers': 'Map<String, MethodMirror> get instanceMembers',
      'staticMembers': 'Map<String, MethodMirror> get staticMembers',
      'mixin': 'ClassMirror<dynamic> get mixin',
      'isEnum': 'bool get isEnum',
      'isPrivate': 'bool get isPrivate',
      'isNullable': 'bool get isNullable',
      'isNonNullable': 'bool get isNonNullable',
      'isPotentiallyNullable': 'bool get isPotentiallyNullable',
      'isPotentiallyNonNullable': 'bool get isPotentiallyNonNullable',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
      'owner': 'DeclarationMirror get owner',
      'superclass': 'ClassMirrorBase<Object> get superclass',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// LibraryMirrorImpl Bridge
// =============================================================================

BridgedClass _createLibraryMirrorImplBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_3.LibraryMirrorImpl,
    name: 'LibraryMirrorImpl',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 8, 'LibraryMirrorImpl');
        final simpleName = D4.getRequiredArg<String>(positional, 0, 'simpleName', 'LibraryMirrorImpl');
        final uri = D4.getRequiredArg<Uri>(positional, 1, 'uri', 'LibraryMirrorImpl');
        final reflector = D4.getRequiredArg<$tom_reflection_3.ReflectionImpl>(positional, 2, '_reflector', 'LibraryMirrorImpl');
        if (positional.length <= 3) {
          throw ArgumentError('LibraryMirrorImpl: Missing required argument "_declarationIndices" at position 3');
        }
        final declarationIndices = D4.coerceList<int>(positional[3], '_declarationIndices');
        if (positional.length <= 4) {
          throw ArgumentError('LibraryMirrorImpl: Missing required argument "getters" at position 4');
        }
        final getters = D4.coerceMap<String, Object? Function()>(positional[4], 'getters');
        if (positional.length <= 5) {
          throw ArgumentError('LibraryMirrorImpl: Missing required argument "setters" at position 5');
        }
        final setters = D4.coerceMap<String, Object? Function(Object?)>(positional[5], 'setters');
        if (positional.length <= 6) {
          throw ArgumentError('LibraryMirrorImpl: Missing required argument "_metadata" at position 6');
        }
        final metadata = D4.coerceListOrNull<Object>(positional[6], '_metadata');
        if (positional.length <= 7) {
          throw ArgumentError('LibraryMirrorImpl: Missing required argument "_parameterListShapes" at position 7');
        }
        final parameterListShapes = D4.coerceMapOrNull<String, int>(positional[7], '_parameterListShapes');
        return $tom_reflection_3.LibraryMirrorImpl(simpleName, uri, reflector, declarationIndices, getters, setters, metadata, parameterListShapes);
      },
    },
    getters: {
      'uri': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').uri,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').simpleName,
      'getters': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').getters,
      'setters': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').setters,
      'declarations': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').declarations,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').metadata,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').owner,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').qualifiedName,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').hashCode,
      'libraryDependencies': (visitor, target) => D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl').libraryDependencies,
    },
    methods: {
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl');
        D4.requireMinArgs(positional, 2, 'invoke');
        final memberName = D4.getRequiredArg<String>(positional, 0, 'memberName', 'invoke');
        final positionalArguments = D4.getRequiredArg<List>(positional, 1, 'positionalArguments', 'invoke');
        final namedArguments = positional.length > 2
            ? D4.coerceMapOrNull<Symbol, dynamic>(positional[2], 'namedArguments')
            : null;
        return t.invoke(memberName, positionalArguments, namedArguments);
      },
      'invokeGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl');
        D4.requireMinArgs(positional, 1, 'invokeGetter');
        final getterName = D4.getRequiredArg<String>(positional, 0, 'getterName', 'invokeGetter');
        return t.invokeGetter(getterName);
      },
      'invokeSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl');
        D4.requireMinArgs(positional, 2, 'invokeSetter');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeSetter');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'invokeSetter');
        return t.invokeSetter(name, value);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.LibraryMirrorImpl>(target, 'LibraryMirrorImpl');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'LibraryMirrorImpl(String simpleName, Uri uri, ReflectionImpl _reflector, List<int> _declarationIndices, Map<String, Object? Function()> getters, Map<String, Object? Function(Object?)> setters, List<Object>? _metadata, Map<String, int>? _parameterListShapes)',
    },
    methodSignatures: {
      'invoke': 'Object? invoke(String memberName, List positionalArguments, [Map<Symbol, dynamic>? namedArguments])',
      'invokeGetter': 'Object? invokeGetter(String getterName)',
      'invokeSetter': 'Object? invokeSetter(String name, Object? value)',
    },
    getterSignatures: {
      'uri': 'Uri get uri',
      'simpleName': 'String get simpleName',
      'getters': 'Map<String, StaticGetter> get getters',
      'setters': 'Map<String, StaticSetter> get setters',
      'declarations': 'Map<String, DeclarationMirror> get declarations',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
      'owner': 'Null get owner',
      'qualifiedName': 'String get qualifiedName',
      'hashCode': 'int get hashCode',
      'libraryDependencies': 'List<LibraryDependencyMirror> get libraryDependencies',
    },
  );
}

// =============================================================================
// MethodMirrorImpl Bridge
// =============================================================================

BridgedClass _createMethodMirrorImplBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_3.MethodMirrorImpl,
    name: 'MethodMirrorImpl',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 10, 'MethodMirrorImpl');
        final name = D4.getRequiredArg<String>(positional, 0, '_name', 'MethodMirrorImpl');
        final descriptor = D4.getRequiredArg<int>(positional, 1, '_descriptor', 'MethodMirrorImpl');
        final ownerIndex = D4.getRequiredArg<int>(positional, 2, '_ownerIndex', 'MethodMirrorImpl');
        final returnTypeIndex = D4.getRequiredArg<int>(positional, 3, '_returnTypeIndex', 'MethodMirrorImpl');
        final reflectedReturnTypeIndex = D4.getRequiredArg<int>(positional, 4, '_reflectedReturnTypeIndex', 'MethodMirrorImpl');
        final dynamicReflectedReturnTypeIndex = D4.getRequiredArg<int>(positional, 5, '_dynamicReflectedReturnTypeIndex', 'MethodMirrorImpl');
        if (positional.length <= 6) {
          throw ArgumentError('MethodMirrorImpl: Missing required argument "_reflectedTypeArgumentsOfReturnType" at position 6');
        }
        final reflectedTypeArgumentsOfReturnType = D4.coerceListOrNull<int>(positional[6], '_reflectedTypeArgumentsOfReturnType');
        if (positional.length <= 7) {
          throw ArgumentError('MethodMirrorImpl: Missing required argument "_parameterIndices" at position 7');
        }
        final parameterIndices = D4.coerceList<int>(positional[7], '_parameterIndices');
        final reflector = D4.getRequiredArg<$tom_reflection_3.ReflectionImpl>(positional, 8, '_reflector', 'MethodMirrorImpl');
        if (positional.length <= 9) {
          throw ArgumentError('MethodMirrorImpl: Missing required argument "_metadata" at position 9');
        }
        final metadata = D4.coerceListOrNull<Object>(positional[9], '_metadata');
        return $tom_reflection_3.MethodMirrorImpl(name, descriptor, ownerIndex, returnTypeIndex, reflectedReturnTypeIndex, dynamicReflectedReturnTypeIndex, reflectedTypeArgumentsOfReturnType, parameterIndices, reflector, metadata);
      },
    },
    getters: {
      'kind': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').kind,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').owner,
      'constructorName': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').constructorName,
      'isAbstract': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isAbstract,
      'isConstConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isConstConstructor,
      'isConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isConstructor,
      'isFactoryConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isFactoryConstructor,
      'isGenerativeConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isGenerativeConstructor,
      'isGetter': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isGetter,
      'isOperator': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isOperator,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isPrivate,
      'isRedirectingConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isRedirectingConstructor,
      'isRegularMethod': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isRegularMethod,
      'isSetter': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isSetter,
      'isStatic': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isStatic,
      'isSynthetic': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isSynthetic,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').metadata,
      'parameters': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').parameters,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').qualifiedName,
      'returnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').returnType,
      'hasReflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').hasReflectedReturnType,
      'reflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').reflectedReturnType,
      'hasDynamicReflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').hasDynamicReflectedReturnType,
      'dynamicReflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').dynamicReflectedReturnType,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').simpleName,
      'source': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').source,
      'numberOfPositionalParameters': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').numberOfPositionalParameters,
      'numberOfOptionalPositionalParameters': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').numberOfOptionalPositionalParameters,
      'namesOfNamedParameters': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').namesOfNamedParameters,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.MethodMirrorImpl>(target, 'MethodMirrorImpl');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'MethodMirrorImpl(String _name, int _descriptor, int _ownerIndex, int _returnTypeIndex, int _reflectedReturnTypeIndex, int _dynamicReflectedReturnTypeIndex, List<int>? _reflectedTypeArgumentsOfReturnType, List<int> _parameterIndices, ReflectionImpl _reflector, List<Object>? _metadata)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'kind': 'int get kind',
      'owner': 'DeclarationMirror get owner',
      'constructorName': 'String get constructorName',
      'isAbstract': 'bool get isAbstract',
      'isConstConstructor': 'bool get isConstConstructor',
      'isConstructor': 'bool get isConstructor',
      'isFactoryConstructor': 'bool get isFactoryConstructor',
      'isGenerativeConstructor': 'bool get isGenerativeConstructor',
      'isGetter': 'bool get isGetter',
      'isOperator': 'bool get isOperator',
      'isPrivate': 'bool get isPrivate',
      'isRedirectingConstructor': 'bool get isRedirectingConstructor',
      'isRegularMethod': 'bool get isRegularMethod',
      'isSetter': 'bool get isSetter',
      'isStatic': 'bool get isStatic',
      'isSynthetic': 'bool get isSynthetic',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
      'parameters': 'List<ParameterMirror> get parameters',
      'qualifiedName': 'String get qualifiedName',
      'returnType': 'TypeMirror get returnType',
      'hasReflectedReturnType': 'bool get hasReflectedReturnType',
      'reflectedReturnType': 'Type get reflectedReturnType',
      'hasDynamicReflectedReturnType': 'bool get hasDynamicReflectedReturnType',
      'dynamicReflectedReturnType': 'Type get dynamicReflectedReturnType',
      'simpleName': 'String get simpleName',
      'source': 'String? get source',
      'numberOfPositionalParameters': 'int get numberOfPositionalParameters',
      'numberOfOptionalPositionalParameters': 'int get numberOfOptionalPositionalParameters',
      'namesOfNamedParameters': 'Set<Symbol> get namesOfNamedParameters',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ImplicitSetterMirrorImpl Bridge
// =============================================================================

BridgedClass _createImplicitSetterMirrorImplBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_3.ImplicitSetterMirrorImpl,
    name: 'ImplicitSetterMirrorImpl',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'ImplicitSetterMirrorImpl');
        final reflector = D4.getRequiredArg<$tom_reflection_3.ReflectionImpl>(positional, 0, 'reflector', 'ImplicitSetterMirrorImpl');
        final variableMirrorIndex = D4.getRequiredArg<int>(positional, 1, 'variableMirrorIndex', 'ImplicitSetterMirrorImpl');
        final selfIndex = D4.getRequiredArg<int>(positional, 2, 'selfIndex', 'ImplicitSetterMirrorImpl');
        return $tom_reflection_3.ImplicitSetterMirrorImpl(reflector, variableMirrorIndex, selfIndex);
      },
    },
    getters: {
      'isGetter': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isGetter,
      'isSetter': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isSetter,
      'parameters': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').parameters,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').qualifiedName,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').simpleName,
      'kind': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').kind,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').owner,
      'constructorName': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').constructorName,
      'isAbstract': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isAbstract,
      'isConstConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isConstConstructor,
      'isConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isConstructor,
      'isFactoryConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isFactoryConstructor,
      'isGenerativeConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isGenerativeConstructor,
      'isOperator': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isOperator,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isPrivate,
      'isRedirectingConstructor': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isRedirectingConstructor,
      'isRegularMethod': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isRegularMethod,
      'isStatic': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isStatic,
      'isSynthetic': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isSynthetic,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').isTopLevel,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').metadata,
      'returnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').returnType,
      'hasReflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').hasReflectedReturnType,
      'reflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').reflectedReturnType,
      'hasDynamicReflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').hasDynamicReflectedReturnType,
      'dynamicReflectedReturnType': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').dynamicReflectedReturnType,
      'source': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').source,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ImplicitSetterMirrorImpl>(target, 'ImplicitSetterMirrorImpl');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'ImplicitSetterMirrorImpl(ReflectionImpl reflector, int variableMirrorIndex, int selfIndex)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isGetter': 'bool get isGetter',
      'isSetter': 'bool get isSetter',
      'parameters': 'List<ParameterMirror> get parameters',
      'qualifiedName': 'String get qualifiedName',
      'simpleName': 'String get simpleName',
      'kind': 'int get kind',
      'owner': 'DeclarationMirror get owner',
      'constructorName': 'String get constructorName',
      'isAbstract': 'bool get isAbstract',
      'isConstConstructor': 'bool get isConstConstructor',
      'isConstructor': 'bool get isConstructor',
      'isFactoryConstructor': 'bool get isFactoryConstructor',
      'isGenerativeConstructor': 'bool get isGenerativeConstructor',
      'isOperator': 'bool get isOperator',
      'isPrivate': 'bool get isPrivate',
      'isRedirectingConstructor': 'bool get isRedirectingConstructor',
      'isRegularMethod': 'bool get isRegularMethod',
      'isStatic': 'bool get isStatic',
      'isSynthetic': 'bool get isSynthetic',
      'isTopLevel': 'bool get isTopLevel',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
      'returnType': 'TypeMirror<dynamic> get returnType',
      'hasReflectedReturnType': 'bool get hasReflectedReturnType',
      'reflectedReturnType': 'Type get reflectedReturnType',
      'hasDynamicReflectedReturnType': 'bool get hasDynamicReflectedReturnType',
      'dynamicReflectedReturnType': 'Type get dynamicReflectedReturnType',
      'source': 'String? get source',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// VariableMirrorImpl Bridge
// =============================================================================

BridgedClass _createVariableMirrorImplBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_3.VariableMirrorImpl,
    name: 'VariableMirrorImpl',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 9, 'VariableMirrorImpl');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'VariableMirrorImpl');
        final descriptor = D4.getRequiredArg<int>(positional, 1, 'descriptor', 'VariableMirrorImpl');
        final ownerIndex = D4.getRequiredArg<int>(positional, 2, 'ownerIndex', 'VariableMirrorImpl');
        final reflection = D4.getRequiredArg<$tom_reflection_3.ReflectionImpl>(positional, 3, 'reflection', 'VariableMirrorImpl');
        final classMirrorIndex = D4.getRequiredArg<int>(positional, 4, 'classMirrorIndex', 'VariableMirrorImpl');
        final reflectedTypeIndex = D4.getRequiredArg<int>(positional, 5, 'reflectedTypeIndex', 'VariableMirrorImpl');
        final dynamicReflectedTypeIndex = D4.getRequiredArg<int>(positional, 6, 'dynamicReflectedTypeIndex', 'VariableMirrorImpl');
        if (positional.length <= 7) {
          throw ArgumentError('VariableMirrorImpl: Missing required argument "reflectedTypeArguments" at position 7');
        }
        final reflectedTypeArguments = D4.coerceListOrNull<int>(positional[7], 'reflectedTypeArguments');
        if (positional.length <= 8) {
          throw ArgumentError('VariableMirrorImpl: Missing required argument "metadata" at position 8');
        }
        final metadata = D4.coerceListOrNull<Object>(positional[8], 'metadata');
        return $tom_reflection_3.VariableMirrorImpl(name, descriptor, ownerIndex, reflection, classMirrorIndex, reflectedTypeIndex, dynamicReflectedTypeIndex, reflectedTypeArguments, metadata);
      },
    },
    getters: {
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').owner,
      'isStatic': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').isStatic,
      'isConst': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').isConst,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').hashCode,
      'kind': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').kind,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').isTopLevel,
      'isFinal': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').isFinal,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').metadata,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').qualifiedName,
      'type': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').type,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').reflectedType,
      'hasDynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').hasDynamicReflectedType,
      'dynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl').dynamicReflectedType,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.VariableMirrorImpl>(target, 'VariableMirrorImpl');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'VariableMirrorImpl(String name, int descriptor, int ownerIndex, ReflectionImpl reflection, int classMirrorIndex, int reflectedTypeIndex, int dynamicReflectedTypeIndex, List<int>? reflectedTypeArguments, List<Object>? metadata)',
    },
    getterSignatures: {
      'owner': 'DeclarationMirror get owner',
      'isStatic': 'bool get isStatic',
      'isConst': 'bool get isConst',
      'hashCode': 'int get hashCode',
      'kind': 'int get kind',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'isFinal': 'bool get isFinal',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'type': 'TypeMirror<dynamic> get type',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'hasDynamicReflectedType': 'bool get hasDynamicReflectedType',
      'dynamicReflectedType': 'Type get dynamicReflectedType',
    },
  );
}

// =============================================================================
// ParameterMirrorImpl Bridge
// =============================================================================

BridgedClass _createParameterMirrorImplBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_3.ParameterMirrorImpl,
    name: 'ParameterMirrorImpl',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 11, 'ParameterMirrorImpl');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ParameterMirrorImpl');
        final descriptor = D4.getRequiredArg<int>(positional, 1, 'descriptor', 'ParameterMirrorImpl');
        final ownerIndex = D4.getRequiredArg<int>(positional, 2, 'ownerIndex', 'ParameterMirrorImpl');
        final reflection = D4.getRequiredArg<$tom_reflection_3.ReflectionImpl>(positional, 3, 'reflection', 'ParameterMirrorImpl');
        final classMirrorIndex = D4.getRequiredArg<int>(positional, 4, 'classMirrorIndex', 'ParameterMirrorImpl');
        final reflectedTypeIndex = D4.getRequiredArg<int>(positional, 5, 'reflectedTypeIndex', 'ParameterMirrorImpl');
        final dynamicReflectedTypeIndex = D4.getRequiredArg<int>(positional, 6, 'dynamicReflectedTypeIndex', 'ParameterMirrorImpl');
        if (positional.length <= 7) {
          throw ArgumentError('ParameterMirrorImpl: Missing required argument "reflectedTypeArguments" at position 7');
        }
        final reflectedTypeArguments = D4.coerceListOrNull<int>(positional[7], 'reflectedTypeArguments');
        if (positional.length <= 8) {
          throw ArgumentError('ParameterMirrorImpl: Missing required argument "metadata" at position 8');
        }
        final metadata = D4.coerceListOrNull<Object>(positional[8], 'metadata');
        final defaultValue = D4.getRequiredArg<Object?>(positional, 9, '_defaultValue', 'ParameterMirrorImpl');
        final nameSymbol = D4.getRequiredArg<Symbol?>(positional, 10, '_nameSymbol', 'ParameterMirrorImpl');
        return $tom_reflection_3.ParameterMirrorImpl(name, descriptor, ownerIndex, reflection, classMirrorIndex, reflectedTypeIndex, dynamicReflectedTypeIndex, reflectedTypeArguments, metadata, defaultValue, nameSymbol);
      },
    },
    getters: {
      'isStatic': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').isStatic,
      'isConst': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').isConst,
      'hasDefaultValue': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').hasDefaultValue,
      'defaultValue': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').defaultValue,
      'isOptional': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').isOptional,
      'isNamed': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').isNamed,
      'owner': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').owner,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').hashCode,
      'kind': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').kind,
      'isPrivate': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').isPrivate,
      'isTopLevel': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').isTopLevel,
      'isFinal': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').isFinal,
      'location': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').location,
      'metadata': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').metadata,
      'simpleName': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').simpleName,
      'qualifiedName': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').qualifiedName,
      'type': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').type,
      'hasReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').hasReflectedType,
      'reflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').reflectedType,
      'hasDynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').hasDynamicReflectedType,
      'dynamicReflectedType': (visitor, target) => D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl').dynamicReflectedType,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ParameterMirrorImpl>(target, 'ParameterMirrorImpl');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'ParameterMirrorImpl(String name, int descriptor, int ownerIndex, ReflectionImpl reflection, int classMirrorIndex, int reflectedTypeIndex, int dynamicReflectedTypeIndex, List<int>? reflectedTypeArguments, List<Object>? metadata, Object? _defaultValue, Symbol? _nameSymbol)',
    },
    getterSignatures: {
      'isStatic': 'bool get isStatic',
      'isConst': 'bool get isConst',
      'hasDefaultValue': 'bool get hasDefaultValue',
      'defaultValue': 'Object? get defaultValue',
      'isOptional': 'bool get isOptional',
      'isNamed': 'bool get isNamed',
      'owner': 'MethodMirror get owner',
      'hashCode': 'int get hashCode',
      'kind': 'int get kind',
      'isPrivate': 'bool get isPrivate',
      'isTopLevel': 'bool get isTopLevel',
      'isFinal': 'bool get isFinal',
      'location': 'SourceLocation get location',
      'metadata': 'List<Object> get metadata',
      'simpleName': 'String get simpleName',
      'qualifiedName': 'String get qualifiedName',
      'type': 'TypeMirror<dynamic> get type',
      'hasReflectedType': 'bool get hasReflectedType',
      'reflectedType': 'Type get reflectedType',
      'hasDynamicReflectedType': 'bool get hasDynamicReflectedType',
      'dynamicReflectedType': 'Type get dynamicReflectedType',
    },
  );
}

// =============================================================================
// ReflectionImpl Bridge
// =============================================================================

BridgedClass _createReflectionImplBridge() {
  return BridgedClass(
    nativeType: $tom_reflection_3.ReflectionImpl,
    name: 'ReflectionImpl',
    constructors: {
    },
    getters: {
      'libraries': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectionImpl>(target, 'ReflectionImpl').libraries,
      'annotatedClasses': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectionImpl>(target, 'ReflectionImpl').annotatedClasses,
      'capabilities': (visitor, target) => D4.validateTarget<$tom_reflection_3.ReflectionImpl>(target, 'ReflectionImpl').capabilities,
    },
    methods: {
      'canReflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ReflectionImpl>(target, 'ReflectionImpl');
        D4.requireMinArgs(positional, 1, 'canReflect');
        final reflectee = D4.getRequiredArg<Object>(positional, 0, 'reflectee', 'canReflect');
        return t.canReflect(reflectee);
      },
      'reflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ReflectionImpl>(target, 'ReflectionImpl');
        D4.requireMinArgs(positional, 1, 'reflect');
        final reflectee = D4.getRequiredArg<Object>(positional, 0, 'reflectee', 'reflect');
        return t.reflect(reflectee);
      },
      'canReflectType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ReflectionImpl>(target, 'ReflectionImpl');
        D4.requireMinArgs(positional, 1, 'canReflectType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'canReflectType');
        return t.canReflectType(type);
      },
      'reflectType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ReflectionImpl>(target, 'ReflectionImpl');
        D4.requireMinArgs(positional, 1, 'reflectType');
        final type = D4.getRequiredArg<Type>(positional, 0, 'type', 'reflectType');
        return t.reflectType(type);
      },
      'findLibrary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_reflection_3.ReflectionImpl>(target, 'ReflectionImpl');
        D4.requireMinArgs(positional, 1, 'findLibrary');
        final libraryName = D4.getRequiredArg<String>(positional, 0, 'libraryName', 'findLibrary');
        return t.findLibrary(libraryName);
      },
    },
    methodSignatures: {
      'canReflect': 'bool canReflect(Object reflectee)',
      'reflect': 'InstanceMirror reflect(Object reflectee)',
      'canReflectType': 'bool canReflectType(Type type)',
      'reflectType': 'TypeMirror reflectType(Type type)',
      'findLibrary': 'LibraryMirror findLibrary(String libraryName)',
    },
    getterSignatures: {
      'libraries': 'Map<Uri, LibraryMirror> get libraries',
      'annotatedClasses': 'Iterable<ClassMirror> get annotatedClasses',
      'capabilities': 'List<ReflectCapability> get capabilities',
    },
  );
}

