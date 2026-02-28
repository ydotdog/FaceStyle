import Foundation

/// 发型数据库 - 包含30款男士发型和50款女士发型
/// Hairstyle Database - Contains 30 male hairstyles and 50 female hairstyles
struct HairstyleDatabase {

    // MARK: - Public Interface

    /// 所有发型 / All hairstyles
    static let allHairstyles: [Hairstyle] = maleHairstyles + femaleHairstyles

    /// 男士发型 / Male hairstyles (30)
    static let maleHairstyles: [Hairstyle] = [
        // =====================================================================
        // MARK: - 1. 圆寸 / Buzz Cut
        // =====================================================================
        Hairstyle(
            id: "m_buzz_cut",
            name: "圆寸 / Buzz Cut",
            description: "经典极短发型，干净利落，展现硬朗气质 / Classic ultra-short style, clean and sharp, showcasing a masculine look",
            suitableFaceShapes: [.oval, .square, .diamond],
            keyBenefits: [
                "突出轮廓分明的骨骼结构 / Highlights well-defined bone structure",
                "清爽干练，适合五官立体的面部 / Clean and sharp, suits faces with prominent features",
                "极低维护成本 / Extremely low maintenance"
            ],
            lengthCategory: .buzz,
            styleCategories: [.textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 1,
            occasions: ["日常 / Casual", "运动 / Sports", "职场 / Professional"]
        ),

        // =====================================================================
        // MARK: - 2. 板寸 / Crew Cut
        // =====================================================================
        Hairstyle(
            id: "m_crew_cut",
            name: "板寸 / Crew Cut",
            description: "两侧极短、顶部稍长的经典短发，精神干练 / Classic short cut with tapered sides and slightly longer top, energetic and sharp",
            suitableFaceShapes: [.oval, .square, .oblong],
            keyBenefits: [
                "为方脸增添柔和感 / Softens angular square faces",
                "顶部微长可调节脸部比例 / Slight top length adjusts facial proportions",
                "简洁大方，适合各种场合 / Neat and versatile for all occasions"
            ],
            lengthCategory: .buzz,
            styleCategories: [.textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 1,
            occasions: ["日常 / Casual", "职场 / Professional", "运动 / Sports"]
        ),

        // =====================================================================
        // MARK: - 3. 寸头渐变 / Skin Fade Buzz
        // =====================================================================
        Hairstyle(
            id: "m_skin_fade_buzz",
            name: "寸头渐变 / Skin Fade Buzz",
            description: "两侧渐变推高，顶部保留极短发量，层次分明 / Skin fade on sides with minimal top length, creating sharp gradient layers",
            suitableFaceShapes: [.oval, .round, .diamond],
            keyBenefits: [
                "渐变效果拉长脸部视觉比例 / Fade effect visually elongates the face",
                "减少圆脸两侧的膨胀感 / Reduces width perception for round faces",
                "现代时尚感强 / Strong modern fashion appeal"
            ],
            lengthCategory: .buzz,
            styleCategories: [.textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "潮流 / Trendy", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 4. 飞机头 / Pompadour
        // =====================================================================
        Hairstyle(
            id: "m_pompadour",
            name: "飞机头 / Pompadour",
            description: "前额头发向上向后梳起，两侧收紧，充满气场 / Hair swept up and back from the forehead with tight sides, full of charisma",
            suitableFaceShapes: [.oval, .round, .heart],
            keyBenefits: [
                "顶部蓬松拉长圆脸比例 / Top volume elongates round face proportions",
                "增加额头高度，平衡心形脸 / Adds forehead height, balances heart-shaped faces",
                "时尚经典，适合各种场合 / Fashionably classic, suits various occasions"
            ],
            lengthCategory: .medium,
            styleCategories: [.textured, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 4,
            occasions: ["社交 / Social", "约会 / Date", "潮流 / Trendy"]
        ),

        // =====================================================================
        // MARK: - 5. 侧分油头 / Side Part Slick Back
        // =====================================================================
        Hairstyle(
            id: "m_side_part_slick",
            name: "侧分油头 / Side Part Slick Back",
            description: "经典绅士侧分，用发油打理出光泽感，成熟稳重 / Classic gentleman's side part with pomade shine, mature and refined",
            suitableFaceShapes: [.oval, .oblong, .diamond],
            keyBenefits: [
                "侧分线条打破长脸的纵向感 / Side part breaks vertical lines of oblong faces",
                "增添横向宽度，平衡菱形脸 / Adds horizontal width, balances diamond faces",
                "正式优雅，职场首选 / Formal and elegant, ideal for professional settings"
            ],
            lengthCategory: .short,
            styleCategories: [.straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["职场 / Professional", "正式 / Formal", "商务 / Business"]
        ),

        // =====================================================================
        // MARK: - 6. 大背头 / Slicked Back
        // =====================================================================
        Hairstyle(
            id: "m_slicked_back",
            name: "大背头 / Slicked Back",
            description: "所有头发向后梳理，露出整个前额，霸气外露 / All hair combed backward exposing the entire forehead, bold and commanding",
            suitableFaceShapes: [.oval, .diamond, .heart],
            keyBenefits: [
                "展露五官，适合轮廓分明的脸型 / Exposes features, suits well-defined facial contours",
                "填补菱形脸窄额头的视觉空间 / Fills visual space of diamond face's narrow forehead",
                "气场强大，彰显自信 / Powerful presence, projects confidence"
            ],
            lengthCategory: .medium,
            styleCategories: [.straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["职场 / Professional", "正式 / Formal", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 7. Undercut
        // =====================================================================
        Hairstyle(
            id: "m_undercut",
            name: "两侧铲青 / Undercut",
            description: "两侧和后部剃短，顶部保留较长头发，对比强烈 / Sides and back shaved short with longer top, creating strong contrast",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "削减两侧宽度，修饰圆脸 / Reduces side width, slims round faces",
                "顶部长发增加纵向高度 / Longer top adds vertical height",
                "收窄下颌宽度的视觉效果，适合梨形脸 / Visually narrows jaw width, suits pear faces"
            ],
            lengthCategory: .medium,
            styleCategories: [.textured, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "潮流 / Trendy", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 8. 纹理烫 / Textured Perm
        // =====================================================================
        Hairstyle(
            id: "m_textured_perm",
            name: "纹理烫 / Textured Perm",
            description: "通过烫发增加自然纹理和蓬松感，打造随性风格 / Adds natural texture and volume through perming, creating an effortless style",
            suitableFaceShapes: [.oval, .oblong, .diamond, .square],
            keyBenefits: [
                "蓬松感增加两侧宽度，缩短长脸视觉 / Volume adds side width, shortens oblong face appearance",
                "柔化方脸的硬朗线条 / Softens angular lines of square faces",
                "自然随性，时尚百搭 / Natural and effortless, versatile fashion appeal"
            ],
            lengthCategory: .short,
            styleCategories: [.textured, .curly],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "约会 / Date", "潮流 / Trendy"]
        ),

        // =====================================================================
        // MARK: - 9. 韩式逗号刘海 / Korean Comma Bangs
        // =====================================================================
        Hairstyle(
            id: "m_comma_bangs",
            name: "韩式逗号刘海 / Korean Comma Bangs",
            description: "刘海呈逗号形状自然分向两侧，清新帅气的韩系风格 / Bangs shaped like a comma falling naturally to the sides, fresh Korean-style look",
            suitableFaceShapes: [.oval, .round, .square, .heart],
            keyBenefits: [
                "刘海遮盖额头宽度，修饰心形脸 / Bangs cover forehead width, refine heart-shaped faces",
                "弧形线条柔化方脸棱角 / Curved lines soften square face angles",
                "清新自然，减龄效果明显 / Fresh and natural, noticeable age-reducing effect"
            ],
            lengthCategory: .short,
            styleCategories: [.bangs, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "约会 / Date", "校园 / Campus"]
        ),

        // =====================================================================
        // MARK: - 10. 韩式中分 / Korean Middle Part
        // =====================================================================
        Hairstyle(
            id: "m_korean_middle_part",
            name: "韩式中分 / Korean Middle Part",
            description: "中间分缝、两侧自然垂落的韩系经典发型 / Classic Korean style with center parting and hair falling naturally on both sides",
            suitableFaceShapes: [.oval, .oblong, .diamond],
            keyBenefits: [
                "两侧发量增加脸部横向宽度 / Side volume adds facial width",
                "修饰菱形脸突出的颧骨 / Conceals prominent cheekbones of diamond faces",
                "文艺气质，温柔感十足 / Artistic temperament, full of gentle charm"
            ],
            lengthCategory: .medium,
            styleCategories: [.straight, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "约会 / Date", "校园 / Campus"]
        ),

        // =====================================================================
        // MARK: - 11. 锡纸烫 / Tin Foil Perm
        // =====================================================================
        Hairstyle(
            id: "m_tin_foil_perm",
            name: "锡纸烫 / Tin Foil Perm",
            description: "用锡纸烫出不规则褶皱纹理，充满个性和潮流感 / Irregular crinkle texture created with tin foil perm, full of personality and trend",
            suitableFaceShapes: [.oval, .oblong, .diamond],
            keyBenefits: [
                "蓬松纹理增加横向视觉，缩短长脸 / Fluffy texture adds horizontal visuals, shortens oblong faces",
                "不规则线条柔化菱形脸棱角 / Irregular lines soften diamond face angles",
                "潮流个性，辨识度高 / Trendy and unique, high recognition"
            ],
            lengthCategory: .short,
            styleCategories: [.textured, .curly],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["潮流 / Trendy", "社交 / Social", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 12. 碎盖头 / Textured Crop
        // =====================================================================
        Hairstyle(
            id: "m_textured_crop",
            name: "碎盖头 / Textured Crop",
            description: "顶部碎发自然前盖，搭配两侧渐变，清爽有型 / Textured top hair falling forward naturally with faded sides, fresh and stylish",
            suitableFaceShapes: [.oval, .oblong, .heart, .diamond],
            keyBenefits: [
                "前盖刘海缩短长脸视觉长度 / Forward-falling fringe shortens oblong face visual length",
                "遮盖宽额头，平衡心形脸 / Covers wide forehead, balances heart-shaped faces",
                "自然碎发感，打理简便 / Natural textured look, easy to style"
            ],
            lengthCategory: .short,
            styleCategories: [.textured, .bangs],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "校园 / Campus", "潮流 / Trendy"]
        ),

        // =====================================================================
        // MARK: - 13. 莫西干 / Mohawk Fade
        // =====================================================================
        Hairstyle(
            id: "m_mohawk_fade",
            name: "莫西干 / Mohawk Fade",
            description: "中间保留一条蓬松发带，两侧渐变铲短，个性十足 / A strip of volume kept in the center with faded sides, highly individualistic",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "中间高度拉长圆脸比例 / Center height elongates round face proportions",
                "收窄视觉宽度，修饰梨形脸下颌 / Narrows visual width, refines pear face jawline",
                "强烈个性表达，适合潮人 / Strong personality expression, suits trendsetters"
            ],
            lengthCategory: .short,
            styleCategories: [.textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 4,
            occasions: ["潮流 / Trendy", "社交 / Social", "演出 / Performance"]
        ),

        // =====================================================================
        // MARK: - 14. 自然短碎发 / Natural Short Layers
        // =====================================================================
        Hairstyle(
            id: "m_natural_short_layers",
            name: "自然短碎发 / Natural Short Layers",
            description: "自然蓬松的短碎发，不刻意打理也好看 / Naturally fluffy short layered cut, looks good without deliberate styling",
            suitableFaceShapes: [.oval, .round, .square, .heart],
            keyBenefits: [
                "柔和层次感修饰各种脸型 / Soft layers refine various face shapes",
                "自然蓬松感减龄效果好 / Natural fluffiness has great age-reducing effect",
                "百搭不挑人，适合日常 / Versatile and universally flattering, suits daily wear"
            ],
            lengthCategory: .short,
            styleCategories: [.layered, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 1,
            occasions: ["日常 / Casual", "校园 / Campus", "职场 / Professional"]
        ),

        // =====================================================================
        // MARK: - 15. 高渐变侧分 / High Fade Side Part
        // =====================================================================
        Hairstyle(
            id: "m_high_fade_side_part",
            name: "高渐变侧分 / High Fade Side Part",
            description: "高位渐变搭配侧分，干净利落的现代绅士风 / High fade paired with a side part, clean modern gentleman style",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "高位渐变极大拉长脸部比例 / High fade greatly elongates facial proportions",
                "侧分增加结构感，显脸小 / Side part adds structure, makes face appear smaller",
                "兼具正式与时尚 / Combines formal and fashionable elements"
            ],
            lengthCategory: .short,
            styleCategories: [.straight, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["职场 / Professional", "社交 / Social", "正式 / Formal"]
        ),

        // =====================================================================
        // MARK: - 16. 法式短寸 / French Crop
        // =====================================================================
        Hairstyle(
            id: "m_french_crop",
            name: "法式短寸 / French Crop",
            description: "顶部平整前梳，前额保留短刘海，简洁时尚 / Flat top combed forward with short front fringe, simple and fashionable",
            suitableFaceShapes: [.oval, .oblong, .heart],
            keyBenefits: [
                "短刘海缩短长脸视觉 / Short fringe shortens oblong face visually",
                "遮盖额头，修饰心形脸 / Covers forehead, refines heart-shaped faces",
                "法式简约，时髦不过时 / French simplicity, trendy yet timeless"
            ],
            lengthCategory: .short,
            styleCategories: [.bangs, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "潮流 / Trendy", "职场 / Professional"]
        ),

        // =====================================================================
        // MARK: - 17. 卷发中分 / Curly Middle Part
        // =====================================================================
        Hairstyle(
            id: "m_curly_middle_part",
            name: "卷发中分 / Curly Middle Part",
            description: "中分卷发自然垂落，复古浪漫的男性魅力 / Curly middle-parted hair falling naturally, vintage romantic masculine charm",
            suitableFaceShapes: [.oval, .oblong, .square],
            keyBenefits: [
                "卷发蓬松感增加脸部横向宽度 / Curly volume adds facial width",
                "柔和曲线软化方脸棱角 / Soft curves soften square face angles",
                "文艺浪漫气质 / Artistic and romantic temperament"
            ],
            lengthCategory: .medium,
            styleCategories: [.curly, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["约会 / Date", "社交 / Social", "潮流 / Trendy"]
        ),

        // =====================================================================
        // MARK: - 18. 微卷刘海 / Wavy Fringe
        // =====================================================================
        Hairstyle(
            id: "m_wavy_fringe",
            name: "微卷刘海 / Wavy Fringe",
            description: "刘海带有自然微卷弧度，打造柔和温暖的形象 / Fringe with natural slight waves, creating a soft warm image",
            suitableFaceShapes: [.oval, .square, .diamond, .heart],
            keyBenefits: [
                "波浪刘海柔化方脸硬朗线条 / Wavy fringe softens hard lines of square faces",
                "遮挡窄额头，平衡菱形脸 / Covers narrow forehead, balances diamond faces",
                "温柔减龄，亲和力强 / Gentle age-reducing effect, strong approachability"
            ],
            lengthCategory: .short,
            styleCategories: [.wavy, .bangs],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "约会 / Date", "校园 / Campus"]
        ),

        // =====================================================================
        // MARK: - 19. 日式蓬松短发 / Japanese Fluffy Short
        // =====================================================================
        Hairstyle(
            id: "m_japanese_fluffy",
            name: "日式蓬松短发 / Japanese Fluffy Short",
            description: "日系空气感蓬松短发，轻盈透气，干净少年感 / Japanese airy fluffy short hair, light and breathable, clean youthful vibe",
            suitableFaceShapes: [.oval, .round, .oblong],
            keyBenefits: [
                "空气感蓬松不显脸大 / Airy fluffiness doesn't make face look large",
                "层次碎发自然修饰脸部轮廓 / Layered texture naturally refines facial contours",
                "清爽少年感，减龄明显 / Fresh youthful vibe, noticeable age-reducing effect"
            ],
            lengthCategory: .short,
            styleCategories: [.layered, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "校园 / Campus", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 20. 狼尾头 / Mullet
        // =====================================================================
        Hairstyle(
            id: "m_mullet",
            name: "狼尾头 / Mullet",
            description: "前短后长的层次造型，后部保留长发尾，个性十足 / Short front with long back layers, retaining long tail, highly individualistic",
            suitableFaceShapes: [.oval, .round, .diamond],
            keyBenefits: [
                "后部长发在视觉上拉长整体轮廓 / Back length visually elongates overall contour",
                "修饰菱形脸颧骨突出问题 / Refines prominent cheekbones of diamond faces",
                "复古潮流，个性鲜明 / Retro trendy, distinctive personality"
            ],
            lengthCategory: .medium,
            styleCategories: [.layered, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["潮流 / Trendy", "社交 / Social", "演出 / Performance"]
        ),

        // =====================================================================
        // MARK: - 21. 中长卷发 / Medium Curly
        // =====================================================================
        Hairstyle(
            id: "m_medium_curly",
            name: "中长卷发 / Medium Curly",
            description: "中等长度的自然卷发，展现不羁的艺术气质 / Medium-length natural curls showcasing an unrestrained artistic temperament",
            suitableFaceShapes: [.oval, .oblong, .square],
            keyBenefits: [
                "卷发体量感缩短长脸视觉 / Curl volume shortens oblong face visually",
                "柔和曲线中和方脸棱角 / Soft curves neutralize square face angles",
                "艺术气质浓厚，辨识度高 / Rich artistic temperament, high recognition"
            ],
            lengthCategory: .medium,
            styleCategories: [.curly, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 4,
            occasions: ["社交 / Social", "潮流 / Trendy", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 22. 三七侧分 / 7:3 Side Part
        // =====================================================================
        Hairstyle(
            id: "m_seven_three_part",
            name: "三七侧分 / 7:3 Side Part",
            description: "三七比例的经典侧分，兼具正式与休闲，万能发型 / Classic 7:3 ratio side part, combining formal and casual, a universal hairstyle",
            suitableFaceShapes: [.oval, .round, .square, .pear],
            keyBenefits: [
                "不对称分线打破圆脸的对称感 / Asymmetric part breaks round face symmetry",
                "斜向线条拉长脸部视觉 / Diagonal lines elongate facial visuals",
                "经典百搭，正式休闲皆宜 / Classic and versatile, suits formal and casual"
            ],
            lengthCategory: .short,
            styleCategories: [.straight, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["职场 / Professional", "日常 / Casual", "正式 / Formal"]
        ),

        // =====================================================================
        // MARK: - 23. 凌乱短发 / Messy Short Hair
        // =====================================================================
        Hairstyle(
            id: "m_messy_short",
            name: "凌乱短发 / Messy Short Hair",
            description: "刻意打造的凌乱感短发，不经意间的帅气 / Deliberately styled messy short hair, casually handsome",
            suitableFaceShapes: [.oval, .square, .diamond, .oblong],
            keyBenefits: [
                "不规则线条柔化方脸和菱形脸的棱角 / Irregular lines soften angles of square and diamond faces",
                "凌乱感增加横向体量，修饰长脸 / Messy volume adds horizontal bulk, refines oblong faces",
                "随性自然，适合日常 / Casual and natural, suits daily wear"
            ],
            lengthCategory: .short,
            styleCategories: [.textured, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "约会 / Date", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 24. 定位烫 / Root Perm
        // =====================================================================
        Hairstyle(
            id: "m_root_perm",
            name: "定位烫 / Root Perm",
            description: "仅在发根处烫发，增加蓬松度和支撑力 / Perming only at the roots to add volume and support",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "发根蓬松增加顶部高度，拉长圆脸 / Root volume increases top height, elongates round faces",
                "自然蓬松，不显刻意 / Natural fluffiness, doesn't look deliberate",
                "提升整体发型持久度 / Improves overall hairstyle longevity"
            ],
            lengthCategory: .short,
            styleCategories: [.textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "职场 / Professional", "校园 / Campus"]
        ),

        // =====================================================================
        // MARK: - 25. 复古侧背 / Vintage Side Sweep
        // =====================================================================
        Hairstyle(
            id: "m_vintage_side_sweep",
            name: "复古侧背 / Vintage Side Sweep",
            description: "灵感来自上世纪绅士风格，头发侧向后梳，光洁有型 / Inspired by vintage gentleman style, hair swept back to the side, sleek and styled",
            suitableFaceShapes: [.oval, .diamond, .oblong],
            keyBenefits: [
                "侧向弧度增加菱形脸额头宽度感 / Side sweep adds forehead width for diamond faces",
                "整洁利落，展现成熟魅力 / Neat and sharp, showcases mature charm",
                "复古优雅，高级感强 / Vintage elegance, strong sense of sophistication"
            ],
            lengthCategory: .medium,
            styleCategories: [.straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 4,
            occasions: ["正式 / Formal", "商务 / Business", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 26. 短刺头 / Spiky Short
        // =====================================================================
        Hairstyle(
            id: "m_spiky_short",
            name: "短刺头 / Spiky Short",
            description: "头发竖立成刺状，充满活力和阳光感 / Hair spiked upward, full of vitality and sunshine",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "竖直发型增加纵向高度，拉长圆脸 / Vertical style adds height, elongates round faces",
                "顶部尖锐感吸引视线上移 / Spiky top draws attention upward",
                "阳光活力，运动感十足 / Sunny vitality, full of sporty energy"
            ],
            lengthCategory: .short,
            styleCategories: [.textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["运动 / Sports", "日常 / Casual", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 27. 渐变中分 / Fade Middle Part
        // =====================================================================
        Hairstyle(
            id: "m_fade_middle_part",
            name: "渐变中分 / Fade Middle Part",
            description: "两侧渐变搭配中分长顶，融合潮流与经典 / Faded sides with middle-parted longer top, blending trend and classic",
            suitableFaceShapes: [.oval, .oblong, .diamond],
            keyBenefits: [
                "中分长顶增加两侧体量，缩短长脸视觉 / Middle-parted top adds side volume, shortens oblong face",
                "两侧发量遮盖菱形脸颧骨 / Side volume covers diamond face cheekbones",
                "潮流与经典的完美结合 / Perfect blend of trendy and classic"
            ],
            lengthCategory: .medium,
            styleCategories: [.layered, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 3,
            occasions: ["潮流 / Trendy", "社交 / Social", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 28. 括号刘海 / Curtain Bangs
        // =====================================================================
        Hairstyle(
            id: "m_curtain_bangs",
            name: "括号刘海 / Curtain Bangs",
            description: "刘海从中间分开向两侧弯曲如括号，修饰脸型效果佳 / Bangs parted from center curving to sides like parentheses, excellent face-framing effect",
            suitableFaceShapes: [.oval, .round, .square, .heart],
            keyBenefits: [
                "弧形刘海遮盖圆脸两侧，显脸小 / Curved bangs cover round face sides, making face look smaller",
                "柔和线条修饰方脸和心形脸 / Soft lines refine square and heart-shaped faces",
                "温柔帅气，适合亚洲面孔 / Gentle and handsome, suits Asian faces"
            ],
            lengthCategory: .short,
            styleCategories: [.bangs, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "约会 / Date", "校园 / Campus"]
        ),

        // =====================================================================
        // MARK: - 29. 两边铲光中长发 / Disconnected Medium
        // =====================================================================
        Hairstyle(
            id: "m_disconnected_medium",
            name: "两边铲光中长发 / Disconnected Medium",
            description: "两侧完全铲光，顶部保留中长头发自由造型 / Sides completely shaved with medium-length top for free styling",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "极致收窄两侧，强力修饰圆脸和梨形脸 / Maximally narrows sides, strongly refines round and pear faces",
                "顶部中长发可变换多种造型 / Medium-length top allows multiple styling options",
                "强烈对比，个性张扬 / Strong contrast, bold personality"
            ],
            lengthCategory: .medium,
            styleCategories: [.textured, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 4,
            occasions: ["潮流 / Trendy", "社交 / Social", "演出 / Performance"]
        ),

        // =====================================================================
        // MARK: - 30. 商务短发 / Business Short Cut
        // =====================================================================
        Hairstyle(
            id: "m_business_short",
            name: "商务短发 / Business Short Cut",
            description: "干净整洁的标准商务短发，两侧修剪利落，顶部自然 / Clean standard business short cut, neat trimmed sides, natural top",
            suitableFaceShapes: [.oval, .round, .square, .oblong],
            keyBenefits: [
                "整洁比例适合大多数脸型 / Neat proportions suit most face shapes",
                "专业形象，增添信任感 / Professional image, adds trustworthiness",
                "低维护高回报，永不过时 / Low maintenance high reward, never goes out of style"
            ],
            lengthCategory: .short,
            styleCategories: [.straight, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .male,
            maintenanceLevel: 1,
            occasions: ["职场 / Professional", "商务 / Business", "正式 / Formal"]
        )
    ]

    /// 女士发型 / Female hairstyles (50)
    static let femaleHairstyles: [Hairstyle] = [
        // =====================================================================
        // MARK: - 1. 法式刘海 / French Bangs
        // =====================================================================
        Hairstyle(
            id: "f_french_bangs",
            name: "法式刘海 / French Bangs",
            description: "轻薄通透的法式碎刘海，随意慵懒的浪漫风情 / Light and airy French wispy bangs, casually lazy romantic style",
            suitableFaceShapes: [.oval, .oblong, .heart],
            keyBenefits: [
                "缩短长脸视觉长度 / Shortens visual length of oblong faces",
                "遮盖心形脸宽额头 / Covers wide forehead of heart-shaped faces",
                "法式慵懒，浪漫优雅 / French laziness, romantic elegance"
            ],
            lengthCategory: .medium,
            styleCategories: [.bangs, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "约会 / Date", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 2. 八字刘海 / Curtain Bangs
        // =====================================================================
        Hairstyle(
            id: "f_curtain_bangs",
            name: "八字刘海 / Curtain Bangs",
            description: "刘海从中间分开呈八字形自然垂落，修颜神器 / Bangs parted from center falling in figure-eight shape, face-refining magic",
            suitableFaceShapes: [.oval, .round, .square, .pear],
            keyBenefits: [
                "两侧弧线修饰颧骨和下颌，显脸小 / Side curves refine cheekbones and jaw, makes face look smaller",
                "柔化方脸的硬朗线条 / Softens hard lines of square faces",
                "适合亚洲面孔，百搭不挑人 / Suits Asian faces, versatile and universally flattering"
            ],
            lengthCategory: .medium,
            styleCategories: [.bangs, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "职场 / Professional", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 3. 空气刘海 / Air Bangs
        // =====================================================================
        Hairstyle(
            id: "f_air_bangs",
            name: "空气刘海 / Air Bangs",
            description: "轻薄透明的韩式空气刘海，若隐若现的额头，甜美减龄 / Thin transparent Korean air bangs, peek-a-boo forehead, sweet and youthful",
            suitableFaceShapes: [.oval, .oblong, .heart, .diamond],
            keyBenefits: [
                "缩短长脸视觉高度 / Shortens visual height of oblong faces",
                "轻柔遮挡宽额头，平衡心形脸 / Gently covers wide forehead, balances heart faces",
                "甜美减龄，韩系清新感 / Sweet and youthful, fresh Korean vibe"
            ],
            lengthCategory: .long,
            styleCategories: [.bangs, .straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "约会 / Date", "校园 / Campus"]
        ),

        // =====================================================================
        // MARK: - 4. 锁骨发 / Collarbone Length
        // =====================================================================
        Hairstyle(
            id: "f_collarbone_length",
            name: "锁骨发 / Collarbone Length",
            description: "发尾恰好落在锁骨位置的中长发，优雅大方 / Medium-long hair ending right at the collarbone, elegant and graceful",
            suitableFaceShapes: [.oval, .round, .square, .pear],
            keyBenefits: [
                "长度刚好修饰脸部到颈部的过渡 / Perfect length to refine face-to-neck transition",
                "拉长圆脸视觉比例 / Elongates round face visual proportions",
                "优雅大方，职场生活两相宜 / Elegant and graceful, suits both work and life"
            ],
            lengthCategory: .medium,
            styleCategories: [.straight, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "职场 / Professional", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 5. 公主切 / Hime Cut
        // =====================================================================
        Hairstyle(
            id: "f_hime_cut",
            name: "公主切 / Hime Cut",
            description: "脸部两侧保留齐切短发层，搭配长发，遮肉显脸小 / Straight-cut short layers on face sides with long hair, conceals and slims face",
            suitableFaceShapes: [.round, .square, .pear, .diamond],
            keyBenefits: [
                "两侧齐切层完美遮盖颧骨和下颌 / Side-cut layers perfectly cover cheekbones and jaw",
                "强力修饰圆脸和方脸 / Strongly refines round and square faces",
                "古典优雅，东方美感 / Classical elegance, Eastern beauty"
            ],
            lengthCategory: .long,
            styleCategories: [.straight, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "约会 / Date", "古风 / Traditional"]
        ),

        // =====================================================================
        // MARK: - 6. 波波头 / Bob Cut
        // =====================================================================
        Hairstyle(
            id: "f_bob_cut",
            name: "波波头 / Bob Cut",
            description: "齐下巴的经典短发，干练优雅，显气质 / Classic chin-length short hair, sharp and elegant, shows temperament",
            suitableFaceShapes: [.oval, .heart, .diamond],
            keyBenefits: [
                "齐下巴长度平衡心形脸窄下巴 / Chin-length balances narrow chin of heart faces",
                "增加下半脸体量，修饰菱形脸 / Adds lower face volume, refines diamond faces",
                "干练时髦，显独立气质 / Sharp and fashionable, shows independent temperament"
            ],
            lengthCategory: .short,
            styleCategories: [.straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["职场 / Professional", "日常 / Casual", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 7. 内扣波波头 / Inward-Curled Bob
        // =====================================================================
        Hairstyle(
            id: "f_inward_bob",
            name: "内扣波波头 / Inward-Curled Bob",
            description: "发尾向内卷曲的波波头，柔和甜美，包裹脸型 / Bob with inward-curling ends, soft and sweet, wrapping around the face",
            suitableFaceShapes: [.oval, .square, .diamond, .pear],
            keyBenefits: [
                "内扣发尾柔化方脸下颌角 / Inward curls soften square face jaw angles",
                "包裹效果遮盖颧骨突出 / Wrapping effect covers prominent cheekbones",
                "甜美温柔，减龄效果好 / Sweet and gentle, great age-reducing effect"
            ],
            lengthCategory: .short,
            styleCategories: [.curly, .straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "约会 / Date", "职场 / Professional"]
        ),

        // =====================================================================
        // MARK: - 8. 大波浪 / Big Waves
        // =====================================================================
        Hairstyle(
            id: "f_big_waves",
            name: "大波浪 / Big Waves",
            description: "大弧度波浪卷发，优雅妩媚，女人味十足 / Large arc wavy curls, elegant and charming, full of femininity",
            suitableFaceShapes: [.oval, .oblong, .heart, .diamond],
            keyBenefits: [
                "大波浪增加两侧体量，缩短长脸视觉 / Big waves add side volume, shorten oblong face visually",
                "丰盈下半脸，平衡心形脸尖下巴 / Enriches lower face, balances pointed chin of heart faces",
                "优雅妩媚，彰显女性魅力 / Elegant and charming, showcases feminine allure"
            ],
            lengthCategory: .long,
            styleCategories: [.wavy, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["约会 / Date", "社交 / Social", "正式 / Formal"]
        ),

        // =====================================================================
        // MARK: - 9. 水波纹卷 / Water Wave Curls
        // =====================================================================
        Hairstyle(
            id: "f_water_wave",
            name: "水波纹卷 / Water Wave Curls",
            description: "如水面涟漪般的S形卷纹，自然灵动的优雅 / S-shaped curl pattern like water ripples, naturally flowing elegance",
            suitableFaceShapes: [.oval, .oblong, .square],
            keyBenefits: [
                "S形曲线增加横向宽度，修饰长脸 / S-shaped curves add horizontal width, refine oblong faces",
                "波纹柔化方脸棱角 / Wave pattern softens square face angles",
                "灵动自然，气质出众 / Flowing and natural, outstanding temperament"
            ],
            lengthCategory: .long,
            styleCategories: [.wavy, .curly],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["约会 / Date", "社交 / Social", "日常 / Casual"]
        ),

        // =====================================================================
        // MARK: - 10. 羊毛卷 / Wool Curls
        // =====================================================================
        Hairstyle(
            id: "f_wool_curls",
            name: "羊毛卷 / Wool Curls",
            description: "密集小卷如羊毛般蓬松，满头卷发充满活力 / Dense small curls fluffy like wool, full head of curls bursting with vitality",
            suitableFaceShapes: [.oval, .oblong, .heart],
            keyBenefits: [
                "极度蓬松体量缩短长脸 / Extreme fluffy volume shortens oblong faces",
                "丰盈下半脸，修饰心形脸尖下巴 / Enriches lower face, refines pointed chin of heart faces",
                "时尚前卫，充满个性 / Fashionably avant-garde, full of personality"
            ],
            lengthCategory: .medium,
            styleCategories: [.curly],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 4,
            occasions: ["潮流 / Trendy", "社交 / Social", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 11. 丸子头 / Bun
        // =====================================================================
        Hairstyle(
            id: "f_bun",
            name: "丸子头 / Bun",
            description: "将头发扎成圆球状盘在头顶，清爽活泼 / Hair gathered into a round ball on top of head, fresh and lively",
            suitableFaceShapes: [.oval, .round, .heart],
            keyBenefits: [
                "高位丸子拉长脸部比例 / High bun elongates facial proportions",
                "露出颈线，显脸小 / Exposes neckline, makes face look smaller",
                "清爽活泼，适合运动和休闲 / Fresh and lively, suits sports and leisure"
            ],
            lengthCategory: .long,
            styleCategories: [.updo],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 1,
            occasions: ["运动 / Sports", "日常 / Casual", "休闲 / Leisure"]
        ),

        // =====================================================================
        // MARK: - 12. 低马尾 / Low Ponytail
        // =====================================================================
        Hairstyle(
            id: "f_low_ponytail",
            name: "低马尾 / Low Ponytail",
            description: "在脑后低位扎起的马尾，知性优雅，气质满分 / Ponytail tied low at the back, intellectual and elegant, full of grace",
            suitableFaceShapes: [.oval, .oblong, .diamond, .heart],
            keyBenefits: [
                "低位绑扎不拉长脸部，适合长脸 / Low tie doesn't elongate face, suits oblong faces",
                "两侧碎发修饰颧骨 / Side wisps refine cheekbones",
                "知性优雅，适合职场 / Intellectual elegance, suits workplace"
            ],
            lengthCategory: .long,
            styleCategories: [.straight, .updo],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 1,
            occasions: ["职场 / Professional", "日常 / Casual", "正式 / Formal"]
        ),

        // =====================================================================
        // MARK: - 13. 高马尾 / High Ponytail
        // =====================================================================
        Hairstyle(
            id: "f_high_ponytail",
            name: "高马尾 / High Ponytail",
            description: "在头顶高位扎起的马尾，精神利落，充满活力 / Ponytail tied high at the crown, energetic and sharp, full of vitality",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "高位马尾拉长圆脸视觉 / High ponytail elongates round face visually",
                "收紧整体轮廓，修饰梨形脸 / Tightens overall contour, refines pear faces",
                "活力满满，青春感强 / Full of vitality, strong youthful energy"
            ],
            lengthCategory: .long,
            styleCategories: [.updo, .straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 1,
            occasions: ["运动 / Sports", "日常 / Casual", "校园 / Campus"]
        ),

        // =====================================================================
        // MARK: - 14. 鱼骨辫 / Fishtail Braid
        // =====================================================================
        Hairstyle(
            id: "f_fishtail_braid",
            name: "鱼骨辫 / Fishtail Braid",
            description: "将头发编成鱼骨状的精致编发，细腻浪漫 / Hair woven into a fishtail pattern, delicate and romantic",
            suitableFaceShapes: [.oval, .round, .heart],
            keyBenefits: [
                "辫子垂落拉长整体视觉 / Braid hanging down elongates overall visuals",
                "两侧拉出碎发修饰圆脸 / Pulled-out wisps on sides refine round faces",
                "精致浪漫，仙气十足 / Delicate and romantic, fairy-like beauty"
            ],
            lengthCategory: .long,
            styleCategories: [.braided],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 4,
            occasions: ["约会 / Date", "婚礼 / Wedding", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 15. 法式编发 / French Braid
        // =====================================================================
        Hairstyle(
            id: "f_french_braid",
            name: "法式编发 / French Braid",
            description: "从头顶开始逐渐加股编织的经典编发 / Classic braid woven from the crown gradually adding strands",
            suitableFaceShapes: [.oval, .oblong, .round],
            keyBenefits: [
                "紧贴头皮编织，收紧整体轮廓 / Close-to-scalp weaving tightens overall contour",
                "露出脸部线条，适合鹅蛋脸展示 / Exposes facial lines, ideal for oval faces to showcase",
                "优雅精致，适合各种场合 / Elegant and refined, suits various occasions"
            ],
            lengthCategory: .long,
            styleCategories: [.braided, .updo],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["约会 / Date", "正式 / Formal", "日常 / Casual"]
        ),

        // =====================================================================
        // MARK: - 16. 双麻花辫 / Double Braids
        // =====================================================================
        Hairstyle(
            id: "f_double_braids",
            name: "双麻花辫 / Double Braids",
            description: "两侧各一条麻花辫，甜美可爱，青春减龄 / One braid on each side, sweet and cute, youthful and age-reducing",
            suitableFaceShapes: [.oval, .oblong, .diamond],
            keyBenefits: [
                "两侧辫子增加横向宽度，修饰长脸 / Side braids add horizontal width, refine oblong faces",
                "遮盖菱形脸突出的颧骨 / Cover prominent cheekbones of diamond faces",
                "甜美减龄，青春活力 / Sweet age-reducing, youthful vitality"
            ],
            lengthCategory: .long,
            styleCategories: [.braided],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "校园 / Campus", "休闲 / Leisure"]
        ),

        // =====================================================================
        // MARK: - 17. 低丸子头 / Low Bun
        // =====================================================================
        Hairstyle(
            id: "f_low_bun",
            name: "低丸子头 / Low Bun",
            description: "在脑后低位盘起的丸子，知性温婉的东方美 / Bun gathered low at the nape, intellectual and gentle Eastern beauty",
            suitableFaceShapes: [.oval, .oblong, .heart, .diamond],
            keyBenefits: [
                "低位盘发不增加头顶高度，适合长脸 / Low bun doesn't add crown height, suits oblong faces",
                "拉出两侧碎发修饰颧骨和额头 / Pulled-out side wisps refine cheekbones and forehead",
                "温婉知性，中式优雅 / Gentle and intellectual, Chinese elegance"
            ],
            lengthCategory: .long,
            styleCategories: [.updo],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["职场 / Professional", "正式 / Formal", "日常 / Casual"]
        ),

        // =====================================================================
        // MARK: - 18. 直发长发 / Long Straight
        // =====================================================================
        Hairstyle(
            id: "f_long_straight",
            name: "直发长发 / Long Straight",
            description: "自然垂直的长直发，清纯温柔的经典形象 / Naturally straight long hair, pure and gentle classic image",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "垂直线条拉长圆脸视觉 / Vertical lines elongate round face visually",
                "两侧直发遮盖梨形脸宽下颌 / Side straight hair covers wide jaw of pear faces",
                "清纯温柔，永恒经典 / Pure and gentle, timeless classic"
            ],
            lengthCategory: .long,
            styleCategories: [.straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "校园 / Campus", "职场 / Professional"]
        ),

        // =====================================================================
        // MARK: - 19. 层次长发 / Long Layers
        // =====================================================================
        Hairstyle(
            id: "f_long_layers",
            name: "层次长发 / Long Layers",
            description: "富有层次感的长发，轻盈灵动，增加动感 / Long hair with rich layers, light and flowing, adding movement",
            suitableFaceShapes: [.oval, .round, .square, .pear],
            keyBenefits: [
                "层次感减轻厚重，不会让圆脸显更圆 / Layers reduce heaviness, won't make round face look rounder",
                "面部周围的层次修饰下颌线 / Face-framing layers refine jawline",
                "灵动飘逸，增添活力 / Flowing and graceful, adds vitality"
            ],
            lengthCategory: .long,
            styleCategories: [.layered, .straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "社交 / Social", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 20. 齐肩发 / Shoulder-Length Cut
        // =====================================================================
        Hairstyle(
            id: "f_shoulder_length",
            name: "齐肩发 / Shoulder-Length Cut",
            description: "长度刚好到肩膀的中等长发，干练又不失女人味 / Medium-length hair just reaching shoulders, sharp yet feminine",
            suitableFaceShapes: [.oval, .round, .heart, .pear],
            keyBenefits: [
                "长度恰好修饰下颌到肩部的过渡 / Length perfectly refines jaw-to-shoulder transition",
                "适中长度平衡心形脸比例 / Moderate length balances heart face proportions",
                "干练优雅，进退自如 / Sharp and elegant, versatile and adaptable"
            ],
            lengthCategory: .medium,
            styleCategories: [.straight, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["职场 / Professional", "日常 / Casual", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 21. 精灵短发 / Pixie Cut
        // =====================================================================
        Hairstyle(
            id: "f_pixie_cut",
            name: "精灵短发 / Pixie Cut",
            description: "超短的精灵系短发，突出五官和脸部轮廓 / Ultra-short pixie-style cut, highlighting features and facial contours",
            suitableFaceShapes: [.oval, .heart, .diamond],
            keyBenefits: [
                "展露优美的鹅蛋脸和心形脸轮廓 / Reveals beautiful oval and heart face contours",
                "突出五官精致度 / Highlights facial feature refinement",
                "个性帅气，独立气场 / Individualistic and cool, independent aura"
            ],
            lengthCategory: .short,
            styleCategories: [.textured, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "潮流 / Trendy", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 22. 短碎发 / Short Shag
        // =====================================================================
        Hairstyle(
            id: "f_short_shag",
            name: "短碎发 / Short Shag",
            description: "层次丰富的蓬松短碎发，随性不羁的时尚态度 / Richly layered fluffy short shag, casually rebellious fashion attitude",
            suitableFaceShapes: [.oval, .oblong, .diamond],
            keyBenefits: [
                "蓬松层次增加宽度，修饰长脸 / Fluffy layers add width, refine oblong faces",
                "碎发遮盖菱形脸突出颧骨 / Shaggy hair covers prominent cheekbones of diamond faces",
                "时髦随性，充满态度 / Trendy and casual, full of attitude"
            ],
            lengthCategory: .short,
            styleCategories: [.layered, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "潮流 / Trendy", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 23. LOB头 / Long Bob (Lob)
        // =====================================================================
        Hairstyle(
            id: "f_lob",
            name: "LOB头 / Long Bob (Lob)",
            description: "加长版波波头，长度在下巴到肩膀之间，百搭经典 / Extended bob with length between chin and shoulders, versatile classic",
            suitableFaceShapes: [.oval, .round, .square, .heart],
            keyBenefits: [
                "长度修饰圆脸下半部 / Length refines lower half of round faces",
                "柔化方脸下颌角 / Softens square face jaw angles",
                "百搭经典，适合各种场合 / Versatile classic, suits all occasions"
            ],
            lengthCategory: .medium,
            styleCategories: [.straight, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "职场 / Professional", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 24. 蛋卷头 / Egg Roll Curls
        // =====================================================================
        Hairstyle(
            id: "f_egg_roll_curls",
            name: "蛋卷头 / Egg Roll Curls",
            description: "规律的蛋卷状波浪卷，复古甜美，韩系时尚 / Regular egg-roll wave curls, retro sweet, Korean fashion",
            suitableFaceShapes: [.oval, .oblong, .heart],
            keyBenefits: [
                "横向波浪增加宽度，修饰长脸 / Horizontal waves add width, refine oblong faces",
                "丰盈下半脸，平衡心形脸 / Enriches lower face, balances heart faces",
                "复古甜美，韩系风格 / Retro sweet, Korean style"
            ],
            lengthCategory: .medium,
            styleCategories: [.curly, .wavy],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["约会 / Date", "社交 / Social", "潮流 / Trendy"]
        ),

        // =====================================================================
        // MARK: - 25. 外翻卷发 / Flipped-Out Curls
        // =====================================================================
        Hairstyle(
            id: "f_flipped_out",
            name: "外翻卷发 / Flipped-Out Curls",
            description: "发尾向外翻翘的活泼卷发，打破沉闷增添灵气 / Outward-flipping lively curls at the ends, breaking monotony and adding spirit",
            suitableFaceShapes: [.oval, .oblong, .pear],
            keyBenefits: [
                "外翻发尾增加下部宽度，平衡长脸 / Flipped ends add lower width, balance oblong faces",
                "外翻弧度转移对梨形脸下颌的注意力 / Flipped curves divert attention from pear face jaw",
                "活泼灵动，打破沉闷 / Lively and spirited, breaks monotony"
            ],
            lengthCategory: .medium,
            styleCategories: [.curly, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "约会 / Date", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 26. 半扎发 / Half-Up Half-Down
        // =====================================================================
        Hairstyle(
            id: "f_half_up",
            name: "半扎发 / Half-Up Half-Down",
            description: "上半部分扎起、下半部分自然垂落的混搭造型 / Upper half tied up with lower half flowing naturally, a mixed style",
            suitableFaceShapes: [.oval, .round, .heart, .pear],
            keyBenefits: [
                "上扎部分拉长圆脸视觉比例 / Tied-up portion elongates round face visual proportions",
                "下垂部分修饰下颌和颈部 / Flowing portion refines jaw and neck",
                "兼具优雅与随性 / Combines elegance with casualness"
            ],
            lengthCategory: .long,
            styleCategories: [.updo, .straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 1,
            occasions: ["日常 / Casual", "约会 / Date", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 27. 法式盘发 / French Twist
        // =====================================================================
        Hairstyle(
            id: "f_french_twist",
            name: "法式盘发 / French Twist",
            description: "将头发向上扭转盘起的经典法式盘发，高贵典雅 / Classic French twist with hair twisted upward, noble and elegant",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "纵向盘起拉长圆脸视觉 / Vertical twist elongates round face visually",
                "收紧整体轮廓，修饰梨形脸 / Tightens overall contour, refines pear faces",
                "高贵典雅，适合正式场合 / Noble and elegant, suits formal occasions"
            ],
            lengthCategory: .long,
            styleCategories: [.updo],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 4,
            occasions: ["正式 / Formal", "婚礼 / Wedding", "晚宴 / Gala"]
        ),

        // =====================================================================
        // MARK: - 28. 日式短发 / Japanese Short Bob
        // =====================================================================
        Hairstyle(
            id: "f_japanese_short_bob",
            name: "日式短发 / Japanese Short Bob",
            description: "日系清爽短发，轻盈空气感，耳后微露 / Japanese-style fresh short hair, light and airy, slightly revealing behind ears",
            suitableFaceShapes: [.oval, .heart, .diamond],
            keyBenefits: [
                "耳后微露增添轻盈感 / Slightly exposed ears add lightness",
                "空气感层次修饰心形脸 / Airy layers refine heart-shaped faces",
                "日系清新，文艺气质 / Japanese freshness, artistic temperament"
            ],
            lengthCategory: .short,
            styleCategories: [.straight, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "校园 / Campus", "文艺 / Artistic"]
        ),

        // =====================================================================
        // MARK: - 29. 韩式微卷中长发 / Korean Soft Curls
        // =====================================================================
        Hairstyle(
            id: "f_korean_soft_curls",
            name: "韩式微卷中长发 / Korean Soft Curls",
            description: "自然微卷的韩系中长发，温柔知性，充满女人味 / Natural soft curls in Korean mid-length style, gentle and intellectual, full of femininity",
            suitableFaceShapes: [.oval, .square, .oblong, .diamond],
            keyBenefits: [
                "微卷弧度柔化方脸棱角 / Soft curl arcs soften square face angles",
                "卷度增加横向宽度，修饰长脸 / Curls add horizontal width, refine oblong faces",
                "温柔知性，韩系优雅 / Gentle and intellectual, Korean elegance"
            ],
            lengthCategory: .medium,
            styleCategories: [.wavy, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "职场 / Professional", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 30. 辛芷蕾发型 / Shaggy Lob
        // =====================================================================
        Hairstyle(
            id: "f_shaggy_lob",
            name: "辛芷蕾发型 / Shaggy Lob",
            description: "上短下长的层次鲜明碎发，洒脱帅气 / Distinct layers with shorter top and longer bottom, free-spirited and cool",
            suitableFaceShapes: [.oval, .round, .pear, .square],
            keyBenefits: [
                "上短下长的层次拉长圆脸 / Short-top-long-bottom layers elongate round faces",
                "蓬松顶部平衡梨形脸宽下颌 / Fluffy top balances wide jaw of pear faces",
                "洒脱帅气，气场全开 / Free-spirited and cool, full aura unleashed"
            ],
            lengthCategory: .medium,
            styleCategories: [.layered, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "社交 / Social", "潮流 / Trendy"]
        ),

        // =====================================================================
        // MARK: - 31. 初恋头 / First Love Bob
        // =====================================================================
        Hairstyle(
            id: "f_first_love_bob",
            name: "初恋头 / First Love Bob",
            description: "下巴长度的微内扣短发，清纯甜美，初恋般的美好 / Chin-length slightly inward-curled short hair, pure and sweet, beautiful like first love",
            suitableFaceShapes: [.oval, .heart, .diamond, .square],
            keyBenefits: [
                "微内扣修饰下颌角 / Slight inward curl refines jaw angle",
                "下巴长度平衡心形脸窄下巴 / Chin length balances narrow chin of heart faces",
                "清纯甜美，减龄神器 / Pure and sweet, age-reducing magic"
            ],
            lengthCategory: .short,
            styleCategories: [.straight, .curly],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "校园 / Campus", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 32. 慵懒卷 / Effortless Curls
        // =====================================================================
        Hairstyle(
            id: "f_effortless_curls",
            name: "慵懒卷 / Effortless Curls",
            description: "自然不刻意的慵懒大卷，仿佛睡醒自然成型 / Natural unintentional lazy curls, as if naturally formed after waking",
            suitableFaceShapes: [.oval, .oblong, .square, .diamond],
            keyBenefits: [
                "蓬松卷度增加宽度，缩短长脸 / Fluffy curls add width, shorten oblong faces",
                "柔和线条修饰方脸和菱形脸 / Soft lines refine square and diamond faces",
                "慵懒时尚，毫不费力的美 / Lazy chic, effortless beauty"
            ],
            lengthCategory: .long,
            styleCategories: [.curly, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "约会 / Date", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 33. 短卷发 / Short Curly
        // =====================================================================
        Hairstyle(
            id: "f_short_curly",
            name: "短卷发 / Short Curly",
            description: "短发搭配柔和卷度，活泼灵动又带成熟韵味 / Short hair with soft curls, lively yet with mature charm",
            suitableFaceShapes: [.oval, .oblong, .heart],
            keyBenefits: [
                "卷度蓬松感修饰长脸 / Curl fluffiness refines oblong faces",
                "丰盈下半脸，修饰心形脸尖下巴 / Enriches lower face, refines pointed chin of heart faces",
                "灵动成熟，别具韵味 / Lively yet mature, uniquely charming"
            ],
            lengthCategory: .short,
            styleCategories: [.curly, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "社交 / Social", "职场 / Professional"]
        ),

        // =====================================================================
        // MARK: - 34. 侧分长发 / Side-Parted Long Hair
        // =====================================================================
        Hairstyle(
            id: "f_side_parted_long",
            name: "侧分长发 / Side-Parted Long Hair",
            description: "经典侧分的长直发或微卷发，知性大气 / Classic side-parted long straight or slightly wavy hair, intellectual and graceful",
            suitableFaceShapes: [.oval, .round, .oblong, .pear],
            keyBenefits: [
                "侧分打破圆脸对称性 / Side part breaks round face symmetry",
                "一侧发量遮盖宽下颌 / Hair on one side covers wide jaw",
                "知性大气，成熟优雅 / Intellectual and graceful, mature elegance"
            ],
            lengthCategory: .long,
            styleCategories: [.straight, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 1,
            occasions: ["职场 / Professional", "日常 / Casual", "正式 / Formal"]
        ),

        // =====================================================================
        // MARK: - 35. 黑长直 / Sleek Black Long
        // =====================================================================
        Hairstyle(
            id: "f_sleek_black_long",
            name: "黑长直 / Sleek Black Long",
            description: "顺滑如丝的黑色长直发，东方经典美的代名词 / Silky smooth black long straight hair, synonym of classic Eastern beauty",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "垂直线条极致拉长圆脸 / Vertical lines maximally elongate round faces",
                "两侧直发完美修饰梨形脸 / Side straight hair perfectly refines pear faces",
                "东方经典美，纯净温婉 / Classic Eastern beauty, pure and gentle"
            ],
            lengthCategory: .long,
            styleCategories: [.straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "正式 / Formal", "古风 / Traditional"]
        ),

        // =====================================================================
        // MARK: - 36. 发尾微卷 / Ends-Only Curls
        // =====================================================================
        Hairstyle(
            id: "f_ends_only_curls",
            name: "发尾微卷 / Ends-Only Curls",
            description: "仅在发尾做出微卷弧度，低调精致的小心机 / Slight curls only at the ends, subtle refined detail",
            suitableFaceShapes: [.oval, .oblong, .heart, .diamond],
            keyBenefits: [
                "发尾微卷增加下部宽度，缩短长脸 / End curls add lower width, shorten oblong faces",
                "丰盈发尾平衡心形脸尖下巴 / Full ends balance pointed chin of heart faces",
                "低调精致，日常百搭 / Subtly refined, versatile daily wear"
            ],
            lengthCategory: .long,
            styleCategories: [.curly, .straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "职场 / Professional", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 37. 短直发 / Short Straight
        // =====================================================================
        Hairstyle(
            id: "f_short_straight",
            name: "短直发 / Short Straight",
            description: "利落干净的短直发，展现独立干练的个人风格 / Clean short straight hair, showcasing independent and sharp personal style",
            suitableFaceShapes: [.oval, .heart, .diamond],
            keyBenefits: [
                "简洁线条展现鹅蛋脸完美比例 / Simple lines showcase perfect oval face proportions",
                "短发凸显心形脸精致下巴 / Short hair highlights refined chin of heart faces",
                "干练独立，个性鲜明 / Sharp and independent, distinctive personality"
            ],
            lengthCategory: .short,
            styleCategories: [.straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 1,
            occasions: ["职场 / Professional", "日常 / Casual", "潮流 / Trendy"]
        ),

        // =====================================================================
        // MARK: - 38. 鲻鱼头 / Female Mullet
        // =====================================================================
        Hairstyle(
            id: "f_mullet",
            name: "鲻鱼头 / Female Mullet",
            description: "前短后长的潮流短发，打破常规的个性表达 / Short front long back trendy cut, unconventional personality expression",
            suitableFaceShapes: [.oval, .round, .diamond],
            keyBenefits: [
                "后部长发拉长整体视觉 / Back length elongates overall visuals",
                "层次感修饰圆脸和菱形脸 / Layered effect refines round and diamond faces",
                "个性前卫，潮流先锋 / Individualistic and avant-garde, trendsetter"
            ],
            lengthCategory: .short,
            styleCategories: [.layered, .textured],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["潮流 / Trendy", "社交 / Social", "演出 / Performance"]
        ),

        // =====================================================================
        // MARK: - 39. 刘海碎发 / Wispy Bangs with Layers
        // =====================================================================
        Hairstyle(
            id: "f_wispy_bangs_layers",
            name: "刘海碎发 / Wispy Bangs with Layers",
            description: "轻薄碎刘海搭配碎层次长发，灵动自然 / Thin wispy bangs paired with layered long hair, flowing and natural",
            suitableFaceShapes: [.oval, .oblong, .heart, .square],
            keyBenefits: [
                "碎刘海缩短长脸视觉高度 / Wispy bangs shorten visual height of oblong faces",
                "柔和碎层修饰方脸硬朗线条 / Soft layers refine hard lines of square faces",
                "自然灵动，仙气飘飘 / Natural and flowing, fairy-like beauty"
            ],
            lengthCategory: .long,
            styleCategories: [.bangs, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "约会 / Date", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 40. 泰迪卷 / Teddy Bear Curls
        // =====================================================================
        Hairstyle(
            id: "f_teddy_curls",
            name: "泰迪卷 / Teddy Bear Curls",
            description: "蓬松可爱的泰迪熊般的短卷发，甜美减龄 / Fluffy cute teddy-bear-like short curls, sweet and youthful",
            suitableFaceShapes: [.oval, .oblong, .heart],
            keyBenefits: [
                "蓬松卷度增加横向宽度，修饰长脸 / Fluffy curls add horizontal width, refine oblong faces",
                "丰盈效果修饰心形脸窄下巴 / Volume effect refines narrow chin of heart faces",
                "可爱甜美，减龄效果极佳 / Cute and sweet, excellent age-reducing effect"
            ],
            lengthCategory: .short,
            styleCategories: [.curly],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["日常 / Casual", "约会 / Date", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 41. 中分长卷发 / Center-Parted Long Curls
        // =====================================================================
        Hairstyle(
            id: "f_center_part_long_curls",
            name: "中分长卷发 / Center-Parted Long Curls",
            description: "中间分缝搭配大卷长发，优雅大气的女神范 / Center part with large long curls, elegant and graceful goddess style",
            suitableFaceShapes: [.oval, .oblong, .diamond, .square],
            keyBenefits: [
                "两侧卷发增加宽度，缩短长脸 / Side curls add width, shorten oblong faces",
                "卷发遮盖菱形脸颧骨 / Curls cover diamond face cheekbones",
                "优雅大气，女神范十足 / Elegant and graceful, full goddess style"
            ],
            lengthCategory: .long,
            styleCategories: [.curly, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["约会 / Date", "正式 / Formal", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 42. 苹果头 / Apple Bun
        // =====================================================================
        Hairstyle(
            id: "f_apple_bun",
            name: "苹果头 / Apple Bun",
            description: "头顶扎一个小揪揪的半扎发，可爱俏皮 / A small top knot half-up style, cute and playful",
            suitableFaceShapes: [.oval, .round, .heart],
            keyBenefits: [
                "顶部小揪揪增加头顶高度，拉长圆脸 / Top knot adds crown height, elongates round faces",
                "半扎设计兼顾修颜和可爱 / Half-up design balances face-refining and cuteness",
                "可爱俏皮，甜美减龄 / Cute and playful, sweet and youthful"
            ],
            lengthCategory: .medium,
            styleCategories: [.updo],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 1,
            occasions: ["日常 / Casual", "校园 / Campus", "休闲 / Leisure"]
        ),

        // =====================================================================
        // MARK: - 43. 复古手推波浪 / Vintage Finger Waves
        // =====================================================================
        Hairstyle(
            id: "f_finger_waves",
            name: "复古手推波浪 / Vintage Finger Waves",
            description: "用手指推出的复古S形波浪，旧时代的华丽优雅 / Retro S-shaped waves created with fingers, old-era glamorous elegance",
            suitableFaceShapes: [.oval, .oblong, .heart],
            keyBenefits: [
                "横向波纹增加宽度，平衡长脸 / Horizontal waves add width, balance oblong faces",
                "复古造型展现独特审美品味 / Retro style showcases unique aesthetic taste",
                "华丽优雅，适合隆重场合 / Glamorous elegance, suits grand occasions"
            ],
            lengthCategory: .medium,
            styleCategories: [.wavy],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 5,
            occasions: ["正式 / Formal", "晚宴 / Gala", "婚礼 / Wedding"]
        ),

        // =====================================================================
        // MARK: - 44. 龙须刘海 / Dragon Whisker Bangs
        // =====================================================================
        Hairstyle(
            id: "f_dragon_whisker_bangs",
            name: "龙须刘海 / Dragon Whisker Bangs",
            description: "耳前留出两缕细长碎发如龙须般垂落，修颜利器 / Two thin long wisps left in front of ears falling like dragon whiskers, face-refining weapon",
            suitableFaceShapes: [.round, .square, .pear, .diamond],
            keyBenefits: [
                "两侧细发有效遮盖颧骨和下颌宽度 / Side wisps effectively cover cheekbone and jaw width",
                "柔化方脸和梨形脸的下颌角 / Softens jaw angles of square and pear faces",
                "若隐若现，精致修颜 / Peek-a-boo effect, refined face-refining"
            ],
            lengthCategory: .long,
            styleCategories: [.bangs, .straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "约会 / Date", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 45. 头顶蓬松层次 / Volume Crown Layers
        // =====================================================================
        Hairstyle(
            id: "f_volume_crown",
            name: "头顶蓬松层次 / Volume Crown Layers",
            description: "着重头顶蓬松度的层次剪裁，颅顶增高视觉效果 / Layered cut emphasizing crown volume, visually increasing skull height",
            suitableFaceShapes: [.oval, .round, .pear],
            keyBenefits: [
                "颅顶增高拉长圆脸比例 / Crown height increase elongates round face proportions",
                "上部体量平衡梨形脸宽下颌 / Upper volume balances wide jaw of pear faces",
                "增加发量感，精致显脸小 / Adds volume appearance, refined and face-slimming"
            ],
            lengthCategory: .medium,
            styleCategories: [.layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "职场 / Professional", "社交 / Social"]
        ),

        // =====================================================================
        // MARK: - 46. 侧编鱼骨 / Side Fishtail
        // =====================================================================
        Hairstyle(
            id: "f_side_fishtail",
            name: "侧编鱼骨 / Side Fishtail",
            description: "在一侧编织的鱼骨辫，不对称美感 / Fishtail braid woven on one side, asymmetric beauty",
            suitableFaceShapes: [.oval, .round, .oblong],
            keyBenefits: [
                "侧编不对称打破圆脸对称感 / Side braid asymmetry breaks round face symmetry",
                "侧边辫增加横向视觉，修饰长脸 / Side braid adds horizontal visual, refines oblong faces",
                "优雅浪漫，适合各种场合 / Elegant and romantic, suits various occasions"
            ],
            lengthCategory: .long,
            styleCategories: [.braided],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["约会 / Date", "社交 / Social", "婚礼 / Wedding"]
        ),

        // =====================================================================
        // MARK: - 47. 气垫卷 / Cushion Perm
        // =====================================================================
        Hairstyle(
            id: "f_cushion_perm",
            name: "气垫卷 / Cushion Perm",
            description: "发根蓬松支撑的微卷造型，自然不刻意的饱满感 / Root-volume micro-curl style, naturally full without being deliberate",
            suitableFaceShapes: [.oval, .round, .pear, .oblong],
            keyBenefits: [
                "发根蓬松增加颅顶高度 / Root volume increases crown height",
                "自然微卷不显老 / Natural micro-curls don't look aging",
                "增加发量视觉，改善扁塌 / Increases volume appearance, improves flatness"
            ],
            lengthCategory: .medium,
            styleCategories: [.curly, .layered],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "职场 / Professional", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 48. 双丸子头 / Double Buns
        // =====================================================================
        Hairstyle(
            id: "f_double_buns",
            name: "双丸子头 / Double Buns",
            description: "头顶两侧各扎一个丸子，俏皮可爱充满活力 / Two buns on top of head, playful and cute full of vitality",
            suitableFaceShapes: [.oval, .oblong, .heart],
            keyBenefits: [
                "两侧丸子增加横向宽度，修饰长脸 / Side buns add horizontal width, refine oblong faces",
                "顶部高度平衡心形脸宽额头 / Top height balances wide forehead of heart faces",
                "俏皮可爱，个性鲜明 / Playful and cute, distinctive personality"
            ],
            lengthCategory: .long,
            styleCategories: [.updo],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["休闲 / Leisure", "社交 / Social", "校园 / Campus"]
        ),

        // =====================================================================
        // MARK: - 49. 中长直发配齐刘海 / Medium Straight with Blunt Bangs
        // =====================================================================
        Hairstyle(
            id: "f_medium_blunt_bangs",
            name: "中长直发配齐刘海 / Medium Straight with Blunt Bangs",
            description: "齐刘海搭配中长直发，乖巧文静的邻家女孩感 / Blunt bangs with medium straight hair, well-behaved girl-next-door feel",
            suitableFaceShapes: [.oval, .oblong, .heart, .diamond],
            keyBenefits: [
                "齐刘海大幅缩短长脸视觉高度 / Blunt bangs greatly shorten visual height of oblong faces",
                "遮盖宽额头和窄额头 / Covers both wide and narrow foreheads",
                "乖巧文静，学院风满满 / Well-behaved and quiet, full of preppy style"
            ],
            lengthCategory: .medium,
            styleCategories: [.bangs, .straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 3,
            occasions: ["校园 / Campus", "日常 / Casual", "约会 / Date"]
        ),

        // =====================================================================
        // MARK: - 50. 渐变层次长发 / Graduated Long Layers
        // =====================================================================
        Hairstyle(
            id: "f_graduated_long_layers",
            name: "渐变层次长发 / Graduated Long Layers",
            description: "从短到长的渐变层次，打造丰富动感的飘逸长发 / Graduated layers from short to long, creating rich dynamic flowing long hair",
            suitableFaceShapes: [.oval, .round, .square, .pear],
            keyBenefits: [
                "渐变层次动感十足，修饰圆脸 / Dynamic graduated layers refine round faces",
                "面部周围的短层次柔化方脸 / Short layers around face soften square faces",
                "飘逸灵动，充满生命力 / Flowing and graceful, full of vitality"
            ],
            lengthCategory: .long,
            styleCategories: [.layered, .straight],
            referenceImageName: "hairstyle_placeholder",
            gender: .female,
            maintenanceLevel: 2,
            occasions: ["日常 / Casual", "社交 / Social", "约会 / Date"]
        )
    ]

    // MARK: - Query Methods

    /// 根据性别获取发型列表 / Get hairstyles by gender
    static func hairstyles(for gender: Gender) -> [Hairstyle] {
        switch gender {
        case .male:
            return allHairstyles.filter { $0.gender == .male || $0.gender == .unisex }
        case .female:
            return allHairstyles.filter { $0.gender == .female || $0.gender == .unisex }
        case .unisex:
            return allHairstyles
        }
    }

    /// 根据脸型和可选性别获取推荐发型 / Get recommended hairstyles by face shape and optional gender
    static func hairstyles(for faceShape: FaceShape, gender: Gender? = nil) -> [Hairstyle] {
        let filtered = allHairstyles.filter { hairstyle in
            hairstyle.suitableFaceShapes.contains(faceShape)
        }

        guard let gender = gender else {
            return filtered
        }

        return filtered.filter { hairstyle in
            hairstyle.gender == gender || hairstyle.gender == .unisex
        }
    }
}
