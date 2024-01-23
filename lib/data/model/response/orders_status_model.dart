class MainOrderStatus {
  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;
  String? productType;
  dynamic categoryIds;
  dynamic brandId;
  String? taxModel;
  String? unit;
  int? minQty;
  int? maxQty;

  int? refundable;
  dynamic digitalProductType;
  dynamic digitalFileReady;
  String? images;
  String? thumbnail;
  dynamic featured;
  dynamic flashDeal;
  String? videoProvider;
  dynamic videoUrl;
  String? colors;
  int? variantProduct;
  String? attributes;
  String? choiceOptions;
  String? variation;
  int? published;
  int? unitPrice;
  int? purchasePrice;
  int? tax;
  String? taxType;
  int? discount;
  String? discountType;
  int? currentStock;
  int? minimumOrderQty;
  String? details;
  int? freeShipping;
  dynamic attachment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  String? colorImage;
  int? featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int? requestStatus;
  dynamic deniedNote;
  int? shippingCost;
  int? multiplyQty;
  dynamic tempShippingCost;
  dynamic isShippingCostUpdated;
  String? code;
  int? reviewsCount;
  List<dynamic>? translations;
  List<dynamic>? reviews;

  MainOrderStatus({
    this.id,
    this.addedBy,
    this.userId,
    this.name,
    this.slug,
    this.productType,
    this.categoryIds,
    this.brandId,
    this.taxModel,
    this.unit,
    this.minQty,
    this.maxQty,
    this.refundable,
    this.digitalProductType,
    this.digitalFileReady,
    this.images,
    this.thumbnail,
    this.featured,
    this.flashDeal,
    this.videoProvider,
    this.videoUrl,
    this.colors,
    this.variantProduct,
    this.attributes,
    this.choiceOptions,
    this.variation,
    this.published,
    this.unitPrice,
    this.purchasePrice,
    this.tax,
    this.taxType,
    this.discount,
    this.discountType,
    this.currentStock,
    this.minimumOrderQty,
    this.details,
    this.freeShipping,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.colorImage,
    this.featuredStatus,
    this.metaTitle,
    this.metaDescription,
    this.metaImage,
    this.requestStatus,
    this.deniedNote,
    this.shippingCost,
    this.multiplyQty,
    this.tempShippingCost,
    this.isShippingCostUpdated,
    this.code,
    this.reviewsCount,
    this.translations,
    this.reviews,
  });

  factory MainOrderStatus.fromJson(Map<String, dynamic> json) =>
      MainOrderStatus(
        id: json["id"],
        addedBy: json["added_by"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        productType: json["product_type"],
        categoryIds: json["category_ids"],
        brandId: json["brand_id"],
        taxModel: json["tax_model"],
        unit: json["unit"],
        minQty: json["min_qty"],
        maxQty: json["max_qty"],
        refundable: json["refundable"],
        digitalProductType: json["digital_product_type"],
        digitalFileReady: json["digital_file_ready"],
        images: json["images"],
        thumbnail: json["thumbnail"],
        featured: json["featured"],
        flashDeal: json["flash_deal"],
        videoProvider: json["video_provider"],
        videoUrl: json["video_url"],
        colors: json["colors"],
        variantProduct: json["variant_product"],
        attributes: json["attributes"],
        choiceOptions: json["choice_options"],
        variation: json["variation"],
        published: json["published"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"],
        tax: json["tax"],
        taxType: json["tax_type"],
        discount: json["discount"],
        discountType: json["discount_type"],
        currentStock: json["current_stock"],
        minimumOrderQty: json["minimum_order_qty"],
        details: json["details"],
        freeShipping: json["free_shipping"],
        attachment: json["attachment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
        colorImage: json["color_image"],
        featuredStatus: json["featured_status"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImage: json["meta_image"],
        requestStatus: json["request_status"],
        deniedNote: json["denied_note"],
        shippingCost: json["shipping_cost"],
        multiplyQty: json["multiply_qty"],
        tempShippingCost: json["temp_shipping_cost"],
        isShippingCostUpdated: json["is_shipping_cost_updated"],
        code: json["code"],
        reviewsCount: json["reviews_count"],
        translations: json["translations"] == null
            ? []
            : List<dynamic>.from(json["translations"]!.map((x) => x)),
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "added_by": addedBy,
        "user_id": userId,
        "name": name,
        "slug": slug,
        "product_type": productType,
        "category_ids": categoryIds,
        "brand_id": brandId,
        "tax_model": taxModel,
        "unit": unit,
        "min_qty": minQty,
        "max_qty": maxQty,
        "refundable": refundable,
        "digital_product_type": digitalProductType,
        "digital_file_ready": digitalFileReady,
        "images": images,
        "thumbnail": thumbnail,
        "featured": featured,
        "flash_deal": flashDeal,
        "video_provider": videoProvider,
        "video_url": videoUrl,
        "colors": colors,
        "variant_product": variantProduct,
        "attributes": attributes,
        "choice_options": choiceOptions,
        "variation": variation,
        "published": published,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "tax": tax,
        "tax_type": taxType,
        "discount": discount,
        "discount_type": discountType,
        "current_stock": currentStock,
        "minimum_order_qty": minimumOrderQty,
        "details": details,
        "free_shipping": freeShipping,
        "attachment": attachment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "color_image": colorImage,
        "featured_status": featuredStatus,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_image": metaImage,
        "request_status": requestStatus,
        "denied_note": deniedNote,
        "shipping_cost": shippingCost,
        "multiply_qty": multiplyQty,
        "temp_shipping_cost": tempShippingCost,
        "is_shipping_cost_updated": isShippingCostUpdated,
        "code": code,
        "reviews_count": reviewsCount,
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x)),
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Review {
  int? id;
  int? productId;
  int? customerId;
  dynamic deliveryManId;
  dynamic orderId;
  String? comment;
  String? attachment;
  int? rating;
  int? status;
  int? isSaved;
  DateTime? createdAt;
  DateTime? updatedAt;

  Review({
    this.id,
    this.productId,
    this.customerId,
    this.deliveryManId,
    this.orderId,
    this.comment,
    this.attachment,
    this.rating,
    this.status,
    this.isSaved,
    this.createdAt,
    this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        productId: json["product_id"],
        customerId: json["customer_id"],
        deliveryManId: json["delivery_man_id"],
        orderId: json["order_id"],
        comment: json["comment"],
        attachment: json["attachment"],
        rating: json["rating"],
        status: json["status"],
        isSaved: json["is_saved"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "customer_id": customerId,
        "delivery_man_id": deliveryManId,
        "order_id": orderId,
        "comment": comment,
        "attachment": attachment,
        "rating": rating,
        "status": status,
        "is_saved": isSaved,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
