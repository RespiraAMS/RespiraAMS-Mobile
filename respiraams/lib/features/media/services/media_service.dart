import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';

/// Media endpoints of Respira.Media (`/media-assets/*`).
///
/// The backend accepts one image per request (max 5 MB) and derives the file
/// name and content type from the stream itself.
class MediaService {
  MediaService(this._dio);

  final Dio _dio;

  /// `POST /media-assets?folder=…` — uploads an image and returns its ID.
  Future<String> uploadImage({
    required Uint8List bytes,
    required String filename,
    String? folder,
    String? actorAccountId,
    String? actorRole,
  }) async {
    final form = FormData.fromMap({
      'file': MultipartFile.fromBytes(bytes, filename: filename),
      'actorAccountId': ?actorAccountId,
      'actorRole': ?actorRole,
    });

    final res = await _dio.post(
      '/media-assets',
      queryParameters: {
        if (folder != null && folder.isNotEmpty) 'folder': folder,
      },
      data: form,
    );

    return unwrapScalar(res, (data) => data is String ? data : '$data');
  }

  /// `DELETE /media-assets/{id}` — deletes the stored object and its record.
  /// Deleting an already-removed asset succeeds.
  Future<void> deleteAsset(String id) async {
    final res = await _dio.delete('/media-assets/$id');
    unwrapResult(res);
  }
}

/// DI'd with the shared authenticated Dio.
final mediaServiceProvider = Provider<MediaService>(
  (ref) => MediaService(ref.watch(apiClientProvider)),
);
